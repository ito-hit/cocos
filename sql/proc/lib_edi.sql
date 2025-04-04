CREATE OR REPLACE package lib_edi is
    -- �z�����[�h�^�C�����
    type lt_info_t is record (
        leadtime_keisan_kbn     m_mise.leadtime_keisan_kbn%type,    -- �z�����[�h�^�C���v�Z�敪
        lt                      number                              -- �z�����[�h�^�C���i�����j
    );

    procedure edi_debug_log(message varchar2);
    procedure err_disp;
    function get_clientid return varchar2;
    procedure clear_userid;
	procedure set_userid(p_user_id in varchar2);
    function get_userid return varchar2;
    procedure fix2work(
        p_table_name    in  varchar2,
        p_line_buffer   in  varchar2,
        p_column_list   in out varchar2,
        p_value_list    in out varchar2
    );
    procedure csv2work(
        p_table_name    in  varchar2,
        p_line_buffer   in  varchar2,
        p_column_list   in out varchar2,
        p_value_list    in out varchar2
    );
    function edi_jyusin_no return number;
    function get_jyutyuno return number;
    function is_duplicate_jyutyu(p_d_edi_jyutyu d_edi_jyutyu%rowtype) return boolean;
    function get_lt_info (
        p_kyoten_code m_teisu.teisu_code%type,
        p_tokui_code  m_mise.tokui_code%type,
        p_mise_code   m_mise.mise_code%type
    ) return lt_info_t;

    -- �G���[�`�F�b�N�p�^�[�����
    type error_check_pattern_t is record (
        tokui   varchar2(1),    -- ���Ӑ攻��p�^�[���iA�F���̓R�[�h�AB�F�f�[�^���ځAC�F�X�}�X�^�[�j
        mise    varchar2(1),    -- �X����p�^�[��    �iA�F�f�[�^�AB�F�X�}�X�^�[�j
        kyoten  varchar2(1),    -- ���_����p�^�[��  �iA�F�P��AB�F���Ӑ攻��AC�F�X�}�X�^�[����j
        tanka   varchar2(1)     -- �P������p�^�[��  �iA�F�����P���AB�F���Гo�^�P���j
    );
    procedure error_check(
        p_check_pattern_info    in error_check_pattern_t ,
        p_d_edi_jyutyu          in out d_edi_jyutyu%rowtype
    );
    procedure warning_check(p_d_edi_jyutyu in out d_edi_jyutyu%rowtype);
    procedure set_others_item(p_d_edi_jyutyu in out d_edi_jyutyu%rowtype);

end lib_edi;
/
CREATE OR REPLACE package body lib_edi is

	/*	Script		�F EDI�n�̃p�b�P�[�W�Ńf�o�b�N��EDI_LOG�e�[�u���ɓ�������
		Author		�F K.Sakamoto
		Parameters	�F message  - ���O�ɏo�͂��郁�b�Z�[�W
		Return		�F �Ȃ�
		DataWritten	�F 2025/03/26
		Modified	�F
	*/
    procedure edi_debug_log(message varchar2)
    is
    begin
        -- $if $$debug $then
            execute immediate 'insert into edi_log (message) values (:1)' using message;
        -- $end
        null;
    end edi_debug_log;

	/*	Script		�F ���݂̃Z�b�V�����Ŏg�p����Ă���N���C�A���g�[�����i�[�����j���擾
		Author		�F K.Sakamoto
		Parameters	�F �Ȃ�
		Return		�F �N���C�A���g�[�����i�[�����j
		DataWritten	�F 2025/03/12
		Modified	�F
	*/
    function get_clientid
    return varchar2
    is
        client_id   varchar2(40);
    begin
        -- select
        --     decode( terminal, 'unknown', substr( machine, instr( machine, '\', -1 ) + 1 ), terminal ) into client_id
        -- from v$session
	    -- where audsid	= userenv( 'SESSIONID' );
        client_id := 'unknown';
        select sys_context('userenv', 'terminal') into client_id from dual;
        return  client_id;
    end get_clientid;

	/*	Script		�F �Z�b�V�������ƂɈ�ӂ̃N���C�A���g���ʎq�i���[�U�[ID�j���N���A����
		Author		�F K.Sakamoto
		Parameters	�F �Ȃ�
		Return		�F �Ȃ�
		DataWritten	�F 2025/03/12
		Modified	�F
	*/
    procedure clear_userid
    is
    begin
        dbms_session.clear_identifier;
    end clear_userid;

	/*	Script		�F �Z�b�V�������ƂɈ�ӂ̃N���C�A���g���ʎq�i���[�U�[ID�j��ݒ�
					�F �p�b�P�[�W�ōX�V����ۂȂǂɗ\�߂��̃��\�b�h�ɂă��[�U�[ID�����݂̃f�[�^�x�[�X�Z�b�V������ client_identifier �ɐݒ肵�Ă���
		Author		�F K.Sakamoto
		Parameters	�F p_user_id
		Return		�F �Ȃ�
		DataWritten	�F 2025/03/12
		Modified	�F
	*/
	procedure set_userid(p_user_id in varchar2)
	is
	begin
		dbms_session.set_identifier(p_user_id);
	end set_userid;

	/*	Script		�F �Z�b�V�������ƂɈ�ӂ̃N���C�A���g���ʎq�i���[�U�[ID�j��ԋp
		Author		�F K.Sakamoto
		Parameters	�F �Ȃ�
		Return		�F �Ȃ�
		DataWritten	�F 2025/03/12
		Modified	�F
	*/
    function get_userid
    return varchar2
    is
        l_userid varchar2(40);
    begin
        select nvl(trim(client_identifier), user) into l_userid from v$session where audsid = userenv('sessionid');
        return l_userid;
    exception
        when no_data_found then
            -- �ʏ�͂��蓾�Ȃ�
            return null;
    end get_userid;

	/*	Script		�F �Œ蒷�f�[�^�����[�N�e�[�u����insert����
                    �F ��{���W�b�N�� csv2work �Ɠ���
		Author		�F K.Sakamoto
		Parameters	�F p_table_name     - ���[�N�e�[�u����
                    �F p_line_buffer    - �s�f�[�^
                    �F p_column_list    - INSERT�J�������X�g
                    �F p_value_list     - VALUES���X�g
		Return		�F �Ȃ�
		DataWritten	�F 2025/03/26
		Modified	�F
	*/
    procedure fix2work(
        p_table_name    varchar2,
        p_line_buffer   varchar2,
        p_column_list   in out varchar2,
        p_value_list    in out varchar2
    )
    is
        l_column_type       varchar2(4000);
        l_column_length     number;
        l_result            number;

        l_pos               number := 1;
        l_value             varchar2(4000);
        l_sql               varchar2(4000);
    begin
        if lengthb(trim(p_line_buffer)) < 1 then
            return;
        end if;

        -- ���R�[�h�𕪉����ă��[�N�ɓo�^����
        l_pos := 1;
        for rec in (select column_name from user_tab_columns where table_name = p_table_name and lower(column_name) not in ('lineh', 'line1', 'line2', 'line3') order by column_name)
        loop
            execute immediate 'begin :1 := fnc.get_column_info(:2, :3, :4, :5); end;'
            using out l_result, in p_table_name, in rec.column_name, out l_column_type, out l_column_length;
            l_value := trim(rtrim(substrb(p_line_buffer, l_pos, l_column_length), '�@'));   -- �E�󔒁i�S�p���p�j�̂ݐ؎̂�
            l_pos := l_pos + l_column_length;
            -- ���l�J�����̑Ή�
            if upper(trim(l_column_type)) = upper('number') then
                l_value := to_char(to_number(regexp_replace(l_value, '^0+-', '-')));
            end if;

            -- ��t�B�[���h�� null �Ƃ���i������ 'null' �ł͂Ȃ����ۂ� null ���g���ꍇ�j
            if l_value is null or l_value = '' then
                p_value_list := p_value_list || ', ' || 'null';
            else
                p_value_list := p_value_list || ', ' || '''' || l_value || '''';
            end if;

            p_column_list := p_column_list || ', ' || rec.column_name;
        end loop;

        -- �Ō�̗]�v�ȃJ���}���폜
        p_column_list := ltrim(p_column_list, ', ');
        p_value_list := ltrim(p_value_list, ', ');
        -- �o�^����
        l_sql := 'insert into ' || p_table_name || ' (' || p_column_list || ') values (' || p_value_list || ') ';
        $if $$debug $then
            l_sql := l_sql || 'log errors into err$_' || p_table_name || ' (''load'') reject limit unlimited';
        $end
        l_sql := upper(l_sql);
        edi_debug_log(l_sql);
        execute immediate l_sql;
    exception
        when no_data_found then
            raise_application_error(-20001, p_table_name || ' �Ƃ����e�[�u���͂���܂���B');
        when others then
            raise;
    end fix2work;

	/*	Script		�F CSV�f�[�^�����[�N�e�[�u����insert����
                    �F ��{���W�b�N�� fix2work �Ɠ���
		Author		�F K.Sakamoto
		Parameters	�F p_table_name     - ���[�N�e�[�u����
                    �F p_line_buffer    - �s�f�[�^
                    �F p_column_list    - INSERT�J�������X�g
                    �F p_value_list     - VALUES���X�g
		Return		�F �Ȃ�
		DataWritten	�F 2025/03/26
		Modified	�F
	*/
    procedure csv2work(
        p_table_name    varchar2,
        p_line_buffer   varchar2,
        p_column_list   in out varchar2,
        p_value_list    in out varchar2
    )
    is
        l_column_count      number;
        l_csv_count         number;
        l_column_type       varchar2(4000);
        l_column_length     number;
        l_result            number;

        l_delimiter         varchar2(10) := '(.*?)(,|$)';
        l_pos               number := 1;
        l_value             varchar2(4000);
        l_sql               varchar2(4000);
    begin
        -- �؏o���ڐ��̃`�F�b�N
        select count(*) into l_column_count from user_tab_columns where table_name = p_table_name and lower(column_name) not in ('lineh', 'line1', 'line2', 'line3');
        l_csv_count := REGEXP_COUNT(p_line_buffer, ',') + 1;
        if l_column_count > l_csv_count THEN
            raise_application_error(-20001, '�f�[�^�̍��ڐ��F' || l_csv_count || '���A���[�N�e�[�u���̍��ڐ��F' || l_column_count || '�������Ȃ��ł��B');
        end if;

        -- ���R�[�h�𕪉����ă��[�N�ɓo�^����
        l_pos := 1;
        for rec in (select column_name from user_tab_columns where table_name = p_table_name and lower(column_name) not in ('lineh', 'line1', 'line2', 'line3') order by column_name)
        loop
            execute immediate 'begin :1 := fnc.get_column_info(:2, :3, :4, :5); end;'
            using out l_result, in p_table_name, in rec.column_name, out l_column_type, out l_column_length;
            l_value := regexp_substr(p_line_buffer, l_delimiter, 1, l_pos, null, 1);
            l_value := trim(rtrim(l_value, '�@'));   -- �E�󔒁i�S�p���p�j�̂ݐ؎̂�    ���s�v�ȃn�Y
            l_pos := l_pos + 1;
            -- ���l�J�����̑Ή�
            if upper(trim(l_column_type)) = upper('number') then
                l_value := to_char(to_number(regexp_replace(l_value, '^0+-', '-')));
            end if;

            -- ��t�B�[���h�� null �Ƃ���i������ 'null' �ł͂Ȃ����ۂ� null ���g���ꍇ�j
            if l_value is null or l_value = '' then
                p_value_list := p_value_list || ', ' || 'null';
            else
                p_value_list := p_value_list || ', ' || '''' || l_value || '''';
            end if;

            p_column_list := p_column_list || ', ' || rec.column_name;
        end loop;

        -- �Ō�̗]�v�ȃJ���}���폜
        p_column_list := ltrim(p_column_list, ', ');
        p_value_list := ltrim(p_value_list, ', ');
        -- �o�^����
        l_sql := 'insert into ' || p_table_name || ' (' || p_column_list || ') values (' || p_value_list || ') ';
        $if $$debug $then
            l_sql := l_sql || 'log errors into err$_' || p_table_name || ' (''load'') reject limit unlimited';
        $end
        l_sql := upper(l_sql);
        -- edi_debug_log(l_sql);
        execute immediate l_sql;
    exception
        when no_data_found then
            raise_application_error(-20001, p_table_name || ' �Ƃ����e�[�u���͂���܂���B');
        when others then
            raise;
    end csv2work;

	/*	Script		�F �w�肳�ꂽ�e�[�u����csv�t�@�C���Ƃ��ďo�͂���
		Author		�F K.Sakamoto
		Parameters	�F p_table_name     - ���[�N�e�[�u����
                    �F p_out_file       - �o�̓t�@�C����
		Return		�F �Ȃ�
		DataWritten	�F 2025/03/26
		Modified	�F
	*/
    procedure work2csv(
        p_table_name    varchar2,
        p_out_file      varchar2
    )
    is
        v_file      utl_file.file_type;  -- �o�͗p�t�@�C���̃n���h��
        v_header    varchar2(32767);     -- �w�b�_������i�񖼂��J���}��؂�ɘA���������́j
        v_sql       varchar2(32767);     -- ���Isql����ێ�����ϐ�
        v_cursor    integer;             -- dbms_sql �p�̃J�[�\���ԍ�
        v_col_cnt   number;              -- ��`����J������
        v_value     varchar2(4000);      -- �e�J�����̒l���󂯎��ϐ�
        v_line      varchar2(32767);     -- �e�s��csv������
        rec_tab     dbms_sql.desc_tab;
    begin

        -- �w�b�_�s�̍쐬�Fuser_tab_columns ���� p_table_name �̃J���������擾
        for rec in (select column_name from user_tab_columns where table_name = p_table_name and lower(column_name) not in ('recno') order by column_name)
        loop
            if v_header is null then
                v_header := rec.column_name;
            else
                v_header := v_header || ',' || rec.column_name;
            end if;
        end loop;

        -- �o�͐�
        v_file := utl_file.fopen('your_dir', 'output.csv', 'w', 32767);
        -- �w�b�_�s���t�@�C���ɏo��
        utl_file.put_line(v_file, v_header);

        -- �f�[�^�擾�p�̓��Isql�����쐬
        v_sql := 'select ' || v_header || ' from ' || p_table_name;
        v_cursor := dbms_sql.open_cursor;
        dbms_sql.parse(v_cursor, v_sql, dbms_sql.native);

        -- ���ʃZ�b�g�̃J���������擾���A�e�J�������`
        dbms_sql.describe_columns(v_cursor, v_col_cnt, rec_tab);
        for i in 1 .. v_col_cnt loop
        dbms_sql.define_column(v_cursor, i, v_value, 4000);
        end loop;

        -- ���[�v���Ċe�s���擾���Acsv�`���̕�����ɕϊ����ăt�@�C���ɏ�������
        while dbms_sql.fetch_rows(v_cursor) > 0 loop
            v_line := null;
            for i in 1 .. v_col_cnt loop
                dbms_sql.column_value(v_cursor, i, v_value);
                -- ��NULL�f�[�^�̑Ή����K�v
                if i > 1 then
                    v_line := v_line || ',' || v_value;
                else
                    v_line := v_value;
                end if;
            end loop;
            utl_file.put_line(v_file, v_line);
        end loop;

        -- �J�[�\���ƃt�@�C�����N���[�Y
        dbms_sql.close_cursor(v_cursor);
        utl_file.fclose(v_file);

    exception
        when others then
            if dbms_sql.is_open(v_cursor) then
            dbms_sql.close_cursor(v_cursor);
            end if;
            if utl_file.is_open(v_file) then
            utl_file.fclose(v_file);
            end if;
            raise;
    end work2csv;

	/*	Script		�F EDI��M�ԍ��̔�
		Author		�F K.Sakamoto
		Parameters	�F �Ȃ�
		Return		�F EDI��M�ԍ�
		DataWritten	�F 2025/03/12
		Modified	�F
	*/
    function edi_jyusin_no
    return number
    is
        l_edi_jyusin_no number;
        l_syori_date    m_kihon.syori_date%type;
    begin
        select seq_edi_jyusin_no.nextval into l_edi_jyusin_no from dual;
        select syori_date into l_syori_date from m_kihon where kanri_code = 0;
        l_edi_jyusin_no := l_syori_date * 100 + l_edi_jyusin_no;
        return l_edi_jyusin_no;

    exception
        when others then
            lib_edi.err_disp;
            return null;
    end edi_jyusin_no;

	/*	Script		�F �󒍔ԍ��̔�
		Author		�F K.Sakamoto
		Parameters	�F �Ȃ�
		Return		�F �󒍔ԍ�
		DataWritten	�F 2025/03/12
		Modified	�F
	*/
    function get_jyutyuno
    return number
    is
        l_cnt           number;
        l_jyutyu_no     number;
    begin
        loop
            -- �󒍔ԍ��̔ԁi����ԍ��P�ʁj
            select seq_jyutyu_no.nextval into l_jyutyu_no from dual;
            -- �󒍔ԍ����݃`�F�b�N
            select count(*) into l_cnt from d_jyutyu where jyutyu_no = l_jyutyu_no;
            if l_cnt = 0 then
                exit;
            end if;
        end loop;
        return l_jyutyu_no;

    exception
        when others then
            lib_edi.err_disp;
            return null;
    end get_jyutyuno;

	/*	Script		�F �d����
		Author		�F K.Sakamoto
		Parameters	�F p_d_edi_jyutyu - EDI�󒍃f�[�^�i���ʁj
		Return		�F ture=�d���L�Afalse=�d����
		DataWritten	�F 2025/03/12
		Modified	�F
	*/
    function is_duplicate_jyutyu(p_d_edi_jyutyu d_edi_jyutyu%rowtype)
    return boolean
    is
        l_exists NUMBER;
        l_result        boolean := true;
    begin
        /*
        with target_data as (
            -- �����ΏۂƂȂ�f�[�^
            select *
            from d_edi_jyutyu
            where
                edi_syori_id    = p_d_edi_jyutyu.edi_syori_id
            and edi_hatyu_no    = p_d_edi_jyutyu.edi_hatyu_no
            and edi_hatyu_date  = p_d_edi_jyutyu.edi_hatyu_date
            and edi_mise_code   = p_d_edi_jyutyu.edi_mise_code
            and edi_syohin_code = p_d_edi_jyutyu.edi_syohin_code
        ),
        jyotai_excluded as (
            -- ��ԋ敪��9�i�Ӑ}�I�ɍ폜�j�̃��R�[�h�͏���
            select jyutyu_no, jyutyu_gyo_no
            from d_edi_jyutyu
            where jyotai_kbn = 9
        ),
        jyusin_excluded as (
            -- ���g�̎�M���͏���
            select jyutyu_no, jyutyu_gyo_no
            from d_edi_jyutyu
            where edi_jyusin_no = p_d_edi_jyutyu.edi_jyusin_no
        )
        select case
            when exists (
                select 1
                from target_data d1
                where not exists (
                    select 1
                    from jyusin_excluded d3
                    where
                        d3.jyutyu_no = d1.jyutyu_no
                    and d3.jyutyu_gyo_no = d1.jyutyu_gyo_no
                )
                and not exists (
                    select 1
                    from jyotai_excluded d2
                    where
                        d2.jyutyu_no = d1.jyutyu_no
                    and d2.jyutyu_gyo_no = d1.jyutyu_gyo_no
                )
            )
            then 1
            else 0
        end ret
        into l_exists
        from dual;
        */
        select case
            when exists (
                select 1
                from        d_edi_jyutyu d1
                left join   d_edi_jyutyu d3 on  d3.jyutyu_no = d1.jyutyu_no
                                            and d3.jyutyu_gyo_no = d1.jyutyu_gyo_no
                                            and d3.edi_jyusin_no = p_d_edi_jyutyu.edi_jyusin_no
                left join   d_edi_jyutyu d2 on  d2.jyutyu_no = d1.jyutyu_no
                                            and d2.jyutyu_gyo_no = d1.jyutyu_gyo_no
                                            and d2.jyotai_kbn = 9
                where
                    d1.edi_syori_id    = p_d_edi_jyutyu.edi_syori_id
                and d1.edi_hatyu_no    = p_d_edi_jyutyu.edi_hatyu_no
                and d1.edi_hatyu_date  = p_d_edi_jyutyu.edi_hatyu_date
                and d1.edi_mise_code   = p_d_edi_jyutyu.edi_mise_code
                and d1.edi_syohin_code = p_d_edi_jyutyu.edi_syohin_code
                and d3.edi_jyusin_no is null    -- ���g�̎�M���͏���
                and d2.jyotai_kbn is null       -- ��ԋ敪��9�i�Ӑ}�I�ɍ폜�j�̃��R�[�h�͏���
            )
            then 1
            else 0
        end ret
        into l_exists
        from dual;

        if l_exists = 0 then
            l_result := false;
        end if;
        return l_result;

    exception
        when others then
            lib_edi.err_disp;
            return null;
    end is_duplicate_jyutyu;

	/*	Script		�F �z�����擾
					�F �z�����[�h�^�C���v�Z�敪�Ɣz�����[�h�^�C�����擾
		Author		�F K.Sakamoto
		Parameters	�F p_kyoten_code    - ���_�R�[�h
					�F p_tokui_code		- ���Ӑ�R�[�h
                    �F p_mise_code      - �X�R�[�h
		Return		�F �z�����ں��ތ^
		DataWritten	�F 2025/03/12
		Modified	�F
	*/
    function get_lt_info (
        p_kyoten_code m_teisu.teisu_code%type,
        p_tokui_code  m_mise.tokui_code%type,
        p_mise_code   m_mise.mise_code%type
    ) return lt_info_t
    is
        -- �߂�l�Ƃ��ė��p���郌�R�[�h�^�̕ϐ���錾
        l_lt_info lt_info_t;
    begin
        -- Oracle�����q�̋L�ڂɏC���K�v���H
        -- �ݒ�R��`�F�b�N�̂��߂�INNER JOIN�ɂ��Ă���
        select
            m_mise.leadtime_keisan_kbn, -- �z�����[�h�^�C���v�Z�敪�i1������Ōv�Z�A2�����Љc�Ɠ��Ōv�Z�A3���y���j�����O�j
            m_teisu.teisu_1             -- �z�����[�h�^�C��
        into
            l_lt_info.leadtime_keisan_kbn,
            l_lt_info.lt
        from
                    m_mise
        inner join  m_meisyo on m_meisyo.meisyo_code = m_mise.leadtime_kbn
        inner join  m_teisu  on m_teisu.teisu_kbn  = m_meisyo.meisyo_code
        where
            m_mise.tokui_code   = p_tokui_code
        and m_mise.mise_code    = p_mise_code
        and m_meisyo.meisyo_kbn = 154   -- �Œ�l
        and m_teisu.teisu_code  = p_kyoten_code
        ;

        return l_lt_info;
    exception
        when no_data_found then
            l_lt_info.leadtime_keisan_kbn := -1;
            l_lt_info.lt := -1;
            return l_lt_info;
        when others then
            lib_edi.err_disp;
            return null;
    end get_lt_info;

	/*	Script		�F �G���[�`�F�b�N
					�F �G���[�`�F�b�N�̋��ʉӏ����`�F�b�N���ăG���[�̏ꍇ�͋K��l���Z�b�g����
		Author		�F K.Sakamoto
		Parameters	�F p_check_pattern_info - �G���[�`�F�b�N�p�^�[�����
                    �F p_d_edi_jyutyu       - EDI�󒍃f�[�^�i���ʁj
		Return		�F �Ȃ�
		DataWritten	�F 2025/03/12
		Modified	�F
	*/
    procedure error_check(
        p_check_pattern_info    in error_check_pattern_t ,
        p_d_edi_jyutyu          in out d_edi_jyutyu%rowtype
    )
    is
        l_m_kyoten          m_kyoten%rowtype;
        l_m_mise            m_mise%rowtype;
        l_m_syohin          m_syohin%rowtype;
        l_m_tokui           m_tokui%rowtype;
        l_m_tokui_okuri     m_tokui%rowtype;
        l_lt_ifo            lib_edi.lt_info_t;  -- �z�����[�h�^�C�����

        l_cnt               number;
        l_flg               number;
    begin
            -- edi���Ӑ�@���捞���_�`�F�b�N
            -- edi�X
            /*
            �A�j���o�^�̏ꍇ
            �C�j�I���t���O��1�i�I���j�̏ꍇ
            �E�j�X�t���O��1�i�X�j�̏ꍇ
            */
            begin
                select * into l_m_mise from m_mise where m_mise.tokui_code = p_d_edi_jyutyu.edi_tokui_code and m_mise.mise_code = p_d_edi_jyutyu.edi_mise_code ;
                p_d_edi_jyutyu.edi_error_flg_1 := 0;
                if l_m_mise.syusoku_flg = 1 then
                    p_d_edi_jyutyu.edi_error_flg_1 := 1;
                end if;
                if l_m_mise.heiten_flg = 1 then
                    p_d_edi_jyutyu.edi_error_flg_1 := 1;
                end if;
            exception
                when no_data_found then
                    p_d_edi_jyutyu.edi_error_flg_1 := 1;
                when others then
                    raise;
            end;

            -- ��.���Ӑ�
            /*
            �ȉ��̓G���[
            �A�j���o�^�̏ꍇ
            �C�j�I���t���O��1�i�I���j�̏ꍇ
            �E�j�����~�敪��3�i���S��~�j�̏ꍇ
            */
            begin
                select * into l_m_tokui from m_tokui where m_tokui.tokui_code = p_d_edi_jyutyu.tokui_code;
                p_d_edi_jyutyu.edi_error_flg_5 := 0;
                if l_m_tokui.syusoku_flg = 1 then
                    p_d_edi_jyutyu.edi_error_flg_5 := 1;
                end if;
                if l_m_tokui.torihiki_teisi_kbn = 3 then
                    p_d_edi_jyutyu.edi_error_flg_5 := 1;
                end if;
            exception
                when no_data_found then
                    p_d_edi_jyutyu.edi_error_flg_5 := 1;
                when others then
                    raise;
            end;
            if p_d_edi_jyutyu.edi_error_flg_5 = 0 then
                p_d_edi_jyutyu.torihiki_jyoken_kbn  := l_m_tokui.torihiki_jyoken_kbn;
                p_d_edi_jyutyu.syohizei_kbn         := l_m_tokui.syohizei_kbn;
            else
                p_d_edi_jyutyu.torihiki_jyoken_kbn  := null;
                p_d_edi_jyutyu.syohizei_kbn         := null;
            end if;

            -- ��.�X
            /*
            �A�j���o�^�̏ꍇ
            �C�j�I���t���O��1�i�I���j�̏ꍇ
            �E�j�X�t���O��1�i�X�j�̏ꍇ
            */
            begin
                select * into l_m_mise from m_mise where m_mise.tokui_code = p_d_edi_jyutyu.tokui_code and m_mise.mise_code = p_d_edi_jyutyu.mise_code ;
                p_d_edi_jyutyu.edi_error_flg_1 := 0;
                if l_m_mise.syusoku_flg = 1 then
                    p_d_edi_jyutyu.edi_error_flg_1 := 1;
                end if;
                if l_m_mise.heiten_flg = 1 then
                    p_d_edi_jyutyu.edi_error_flg_1 := 1;
                end if;
            exception
                when no_data_found then
                    p_d_edi_jyutyu.edi_error_flg_1 := 1;
                when others then
                    raise;
            end;

            -- ���Ӑ�i���蓾�Ӑ�Q�Ɓj
            /*
            �ȉ��̓G���[
            �A�j���o�^�̏ꍇ
            �C�j�I���t���O��1�i�I���j�̏ꍇ
            �E�j�����~�敪��3�i���S��~�j�̏ꍇ
            */
            begin
                select * into l_m_tokui from m_tokui where m_tokui.tokui_code = p_d_edi_jyutyu.okuri_tokui_code;
                p_d_edi_jyutyu.edi_error_flg_2 := 0;
                if l_m_tokui.syusoku_flg = 1 then
                    p_d_edi_jyutyu.edi_error_flg_2 := 1;
                end if;
                if l_m_tokui.torihiki_teisi_kbn = 3 then
                    p_d_edi_jyutyu.edi_error_flg_2 := 1;
                end if;
            exception
                when no_data_found then
                    p_d_edi_jyutyu.edi_error_flg_2 := 1;
                when others then
                    raise;
            end;
            if p_d_edi_jyutyu.edi_error_flg_2 = 0 then
                p_d_edi_jyutyu.okuri_tokui_mei := l_m_tokui.tokui_mei_syagai;
            else
                p_d_edi_jyutyu.okuri_tokui_mei := null;
            end if;

            -- �X�`�F�b�N�i�����j
            /*
            �A�j���o�^�̏ꍇ
            �C�j�I���t���O��1�i�I���j�̏ꍇ
            �E�j�X�t���O��1�i�X�j�̏ꍇ
            */
            if p_d_edi_jyutyu.edi_error_flg_2 = 0 then
                begin
                    select * into l_m_mise from m_mise where m_mise.tokui_code = p_d_edi_jyutyu.okuri_tokui_code and m_mise.mise_code = p_d_edi_jyutyu.okuri_mise_code ;
                    p_d_edi_jyutyu.edi_error_flg_2 := 0;
                    if l_m_mise.syusoku_flg = 1 then
                        p_d_edi_jyutyu.edi_error_flg_2 := 1;
                    end if;
                    if l_m_mise.heiten_flg = 1 then
                        p_d_edi_jyutyu.edi_error_flg_2 := 1;
                    end if;
                exception
                    when no_data_found then
                        p_d_edi_jyutyu.edi_error_flg_2 := 1;
                    when others then
                        raise;
                end;
            end if;
            -- ����悪�擾�o�����ꍇ�̓}�X�^�[����̍��ڃZ�b�g�i���擾�̎���null�Ń��Z�b�g�j
            if p_d_edi_jyutyu.edi_error_flg_2 = 0 then
                p_d_edi_jyutyu.kobetu_haiso_flg     := l_m_mise.kobetu_haiso_flg ;
                p_d_edi_jyutyu.yubin_no             := l_m_mise.yubin_no         ;
                p_d_edi_jyutyu.jyusyo1              := l_m_mise.jyusyo1          ;
                p_d_edi_jyutyu.jyusyo2              := l_m_mise.jyusyo2          ;
                p_d_edi_jyutyu.jyusyo3              := l_m_mise.jyusyo3          ;
                p_d_edi_jyutyu.okuri_mei1           := l_m_mise.okuri_mei1       ;
                p_d_edi_jyutyu.okuri_mei2           := l_m_mise.okuri_mei2       ;
                p_d_edi_jyutyu.tel_no               := l_m_mise.tel_no           ;
                p_d_edi_jyutyu.unso_code            := l_m_mise.unso_code        ;
                p_d_edi_jyutyu.tyakuten_code        := l_m_mise.tyakuten_code    ;
                p_d_edi_jyutyu.tyakuten_tome_flg    := l_m_mise.tyakuten_tome_flg;
                p_d_edi_jyutyu.niokurinin_code      := l_m_mise.niokurinin_code  ;
            else
                p_d_edi_jyutyu.kobetu_haiso_flg     := null;
                p_d_edi_jyutyu.yubin_no             := null;
                p_d_edi_jyutyu.jyusyo1              := null;
                p_d_edi_jyutyu.jyusyo2              := null;
                p_d_edi_jyutyu.jyusyo3              := null;
                p_d_edi_jyutyu.okuri_mei1           := null;
                p_d_edi_jyutyu.okuri_mei2           := null;
                p_d_edi_jyutyu.tel_no               := null;
                p_d_edi_jyutyu.unso_code            := null;
                p_d_edi_jyutyu.tyakuten_code        := null;
                p_d_edi_jyutyu.tyakuten_tome_flg    := null;
                p_d_edi_jyutyu.niokurinin_code      := null;
            end if;

            -- �B���i�`�F�b�N
            begin
                select
                    m_syohin.* into l_m_syohin
                from
                            m_gtin
                inner join  m_syohin    on  m_syohin.sku_code = m_gtin.sku_code
                where
                    m_gtin.gtin_code = p_d_edi_jyutyu.edi_syohin_code
                and m_gtin.code_kbn = 1
                ;
                p_d_edi_jyutyu.edi_error_flg_3 := 0;
            exception
                when no_data_found then
                    begin
                        select m_syohin.* into l_m_syohin
                        from m_syohin
                        where m_syohin.sku_code = (
                            select sku_code
                            from (
                                select m_aite_hinban.sku_code
                                from m_aite_hinban
                                where m_aite_hinban.tokui_code = p_d_edi_jyutyu.okuri_tokui_code
                                and m_aite_hinban.syohin_code = p_d_edi_jyutyu.edi_syohin_code
                                order by m_aite_hinban.touroku_date
                            ) where rownum = 1
                        )
                        ;
                        p_d_edi_jyutyu.edi_error_flg_3 := 0;
                    exception
                        when no_data_found THEN
                            p_d_edi_jyutyu.edi_error_flg_3 := 1;
                    when others then
                        fnc.disp_out('���i�ǂݍ��݃G���[�F' || p_d_edi_jyutyu.edi_syohin_code);
                        raise;
                    end;
                when others then
                    raise;
            end;
            -- ���i�}�X�^����̃Z�b�g
            if p_d_edi_jyutyu.edi_error_flg_3 = 0 then
                p_d_edi_jyutyu.syohin_code          := l_m_syohin.syohin_code       ;
                p_d_edi_jyutyu.iro_no               := l_m_syohin.iro_no            ;
                p_d_edi_jyutyu.sku_code             := l_m_syohin.sku_code          ;
                p_d_edi_jyutyu.hin_ban              := l_m_syohin.hin_ban           ;
                p_d_edi_jyutyu.hin_mei              := l_m_syohin.hin_mei           ;
                p_d_edi_jyutyu.iro_mei              := l_m_syohin.iro_mei           ;
                p_d_edi_jyutyu.size_mei             := l_m_syohin.size_mei          ;
                p_d_edi_jyutyu.genka_tanka          := l_m_syohin.hyojyun_genka     ;
                p_d_edi_jyutyu.syokuti_syohin_flg   := l_m_syohin.syokuti_flg;
                p_d_edi_jyutyu.suryo_keisan_flg     := l_m_syohin.suryo_keisan_flg  ;
                p_d_edi_jyutyu.kingaku_keisan_flg   := l_m_syohin.kingaku_keisan_flg;
                p_d_edi_jyutyu.arari_keisan_flg     := l_m_syohin.arari_keisan_flg  ;
                p_d_edi_jyutyu.hako_keisan_flg      := l_m_syohin.hako_keisan_flg   ;
                p_d_edi_jyutyu.kenpin_taisyo_flg    := l_m_syohin.kenpin_taisyo_flg ;
            else
                p_d_edi_jyutyu.syohin_code          := null;
                p_d_edi_jyutyu.iro_no               := null;
                p_d_edi_jyutyu.sku_code             := null;
                p_d_edi_jyutyu.hin_ban              := null;
                p_d_edi_jyutyu.hin_mei              := null;
                p_d_edi_jyutyu.iro_mei              := null;
                p_d_edi_jyutyu.size_mei             := null;
                p_d_edi_jyutyu.genka_tanka          := null;
                p_d_edi_jyutyu.syokuti_syohin_flg   := null;
                p_d_edi_jyutyu.suryo_keisan_flg     := null;
                p_d_edi_jyutyu.kingaku_keisan_flg   := null;
                p_d_edi_jyutyu.arari_keisan_flg     := null;
                p_d_edi_jyutyu.hako_keisan_flg      := null;
                p_d_edi_jyutyu.kenpin_taisyo_flg    := null;
            end if;

            -- �P���`�F�b�N
            if nvl(p_d_edi_jyutyu.tanka,0) > 0 then
                p_d_edi_jyutyu.edi_error_flg_4 := 0;
            else
                p_d_edi_jyutyu.edi_error_flg_4 := 1;
            end if;

            -- ���̑��`�F�b�N

            -- ���_
            p_d_edi_jyutyu.kyoten_code := p_d_edi_jyutyu.edi_kyoten_code;   -- ���_�R�[�h�@���P�ꋒ�_�p�^�[��
            if p_d_edi_jyutyu.kyoten_code = 0 then
                begin
                    select * into l_m_kyoten from m_kyoten where m_kyoten.kyoten_code = p_d_edi_jyutyu.kyoten_code;
                    /*
                    �ȉ��̓G���[
                    �A�j���o�^�̏ꍇ
                    �C�j���_�敪��1�i�o�׋��_�j�ȊO�̏ꍇ
                    �E�j�݌ɊǗ��t���O��1�i�݌ɊǗ�����j�ȊO�̏ꍇ
                    �G�jwms �ғ��敪��3�i�����Z���^�[�V�X�e���������_�j�ȊO�̏ꍇ
                    */
                    -- ��Ƀ`�F�b�N���Ă��� p_d_edi_jyutyu.edi_error_flg_5 ���N���A���Ȃ����ߕʕϐ��ɂĔ��肷��
                    l_flg := 0;
                    if l_m_kyoten.kyoten_kbn <> 1 then
                        l_flg := 1;
                    end if;
                    if l_m_kyoten.zaiko_kanri_flg <> 1 then
                        l_flg := 1;
                    end if;
                    if l_m_kyoten.wms_kadou_kbn <> 3 then
                        l_flg := 1;
                    end if;
                exception
                    when no_data_found then
                        l_flg := 1;
                    when others then
                        raise;
                end;
                if l_flg = 0 then
                    p_d_edi_jyutyu.kyoten_code := l_m_kyoten.kyoten_code;
                else
                    p_d_edi_jyutyu.kyoten_code := l_m_kyoten.kyoten_code;   -- �N���A�����Z�b�g���Ă���
                    p_d_edi_jyutyu.edi_error_flg_5 := 1;
                end if;
            end if;

            -- EDI�z������
            l_lt_ifo := lib_edi.get_lt_info(p_d_edi_jyutyu.kyoten_code, p_d_edi_jyutyu.okuri_tokui_code, p_d_edi_jyutyu.okuri_mise_code);
            p_d_edi_jyutyu.EDI_HAISO_NISSU := l_lt_ifo.lt;
            if p_d_edi_jyutyu.EDI_HAISO_NISSU = -1 then
                    p_d_edi_jyutyu.edi_error_flg_5 := 1;
            end if;

    exception
        when others then
            lib_edi.err_disp;
    end error_check;

	/*	Script		�F ���[�j���O�`�F�b�N
					�F ���[�j���O�`�F�b�N�̋��ʉӏ����`�F�b�N����
		Author		�F K.Sakamoto
		Parameters	�F p_d_edi_jyutyu - EDI�󒍃f�[�^�i���ʁj�@��ByRef
		Return		�F �Ȃ�
		DataWritten	�F 2025/03/12
		Modified	�F
	*/
    procedure warning_check(p_d_edi_jyutyu in out d_edi_jyutyu%rowtype)
    is
    begin
            -- �d���`�F�b�N
            if is_duplicate_jyutyu(p_d_edi_jyutyu) then
                p_d_edi_jyutyu.edi_keikoku_flg_1 := 1;
            else
                p_d_edi_jyutyu.edi_keikoku_flg_1 := 0;
            end if;

            -- ���t�`�F�b�N
                p_d_edi_jyutyu.edi_keikoku_flg_2 := 0;

                p_d_edi_jyutyu.edi_keikoku_flg_3 := 0;

            -- �P���`�F�b�N
            if nvl(p_d_edi_jyutyu.edi_tanka,0) = nvl(p_d_edi_jyutyu.genka_tanka,0) then
                p_d_edi_jyutyu.edi_keikoku_flg_4 := 0;
            else
                p_d_edi_jyutyu.edi_keikoku_flg_4 := 1;
            end if;

            -- ���̑��`�F�b�N
                p_d_edi_jyutyu.edi_keikoku_flg_5 := 0;

    exception
        when others then
            lib_edi.err_disp;
    end warning_check;

	/*	Script		�F ���̑����ڂ̕ҏW
					�F �ǂ��܂ŋ��ʂœ]���o����̂��͕s��
                    �F ��F�e�푊��敪�͋��ʎd�l�ł� a�`i �܂ł��邪�A�R�V�Ȃǂ́Aa,b�̂ݓ]���Ȃ̂ōŒ����]�L
		Author		�F K.Sakamoto
		Parameters	�F p_d_edi_jyutyu - EDI�󒍃f�[�^�i���ʁj�@��ByRef
		Return		�F �Ȃ�
		DataWritten	�F 2025/03/12
		Modified	�F
	*/
    procedure set_others_item(p_d_edi_jyutyu in out d_edi_jyutyu%rowtype)
    is
        l_jis_code      m_yubin.jis_code%type;  -- �S���n�������c�̃R�[�h�i�S���n�������c�̃R�[�h�j��������
    begin
        -- ���ʉ��H�敪�P   ���ʉ��HM.�������ځi�����̓��Ӑ�R�[�h�{���i�R�[�h�ɂĎQ�Ɓj
        begin
            select ryutu_kako_kbn1 into p_d_edi_jyutyu.ryutu_kako_kbn1 from m_ryutu_kako where tokui_code = p_d_edi_jyutyu.okuri_tokui_code and syohin_code = p_d_edi_jyutyu.syohin_code;
        exception
            when no_data_found then
                p_d_edi_jyutyu.ryutu_kako_kbn1 := null;
            when others then
                raise;
        end;
        -- �X�֔ԍ�M�Q��
        begin
            select jis_code into l_jis_code from m_yubin where yubin_no = p_d_edi_jyutyu.yubin_no;
            p_d_edi_jyutyu.todofuken_code := substrb(l_jis_code, 1, 2);    -- �s���{���R�[�h   �X�֔ԍ�M.�S���n�������c�̃R�[�h�̐擪2�o�C�g
            p_d_edi_jyutyu.sikutyoson_code := l_jis_code;                  -- �s�撬���R�[�h   �X�֔ԍ�M.�S���n�������c�̃R�[�h
        exception
            when no_data_found then
                 l_jis_code:= null;
            when others then
                raise;
        end;

        -- ����`�[�敪��   ���薼��M.����1�i���̋敪��004�j������`�[�敪<>NULL�̏ꍇ
        if p_d_edi_jyutyu.aite_denpyo_kbn is not null then
            begin
                select meisyo_1 into p_d_edi_jyutyu.aite_denpyo_kbn_mei from m_aite_meisyo where tokui_code = p_d_edi_jyutyu.okuri_tokui_code and meisyo_kbn = '004';
            exception
                when no_data_found then
                    p_d_edi_jyutyu.aite_denpyo_kbn_mei := null;
                when others then
                    raise;
            end;
        end if;

        --���蕔�喼        ���薼��M.����1�i���̋敪��003�j�����蕔��R�[�h<>NULL�̏ꍇ
        if p_d_edi_jyutyu.AITE_BUMON_CODE is not null then
            begin
                select meisyo_1 into p_d_edi_jyutyu.aite_bumon_mei from m_aite_meisyo where tokui_code = p_d_edi_jyutyu.okuri_tokui_code and meisyo_kbn = '003';
            exception
                when no_data_found then
                    null;
                when others then
                    raise;
            end;
        end if;
    exception
        when others then
            lib_edi.err_disp;
    end set_others_item;

	/*	Script		�F EDI�n�̃p�b�P�[�W�ŃG���[�������������̃f�o�b�O�\��
		Author		�F K.Sakamoto
		Parameters	�F �Ȃ�
		Return		�F �Ȃ�
		DataWritten	�F 2025/03/26
		Modified	�F
	*/
    procedure err_disp
    is
        v_error_message     varchar2(4000);
        v_error_stack       varchar2(4000);
        v_error_backtrace   varchar2(4000);
    begin
            -- �G���[�����O���[�o���ϐ��ɃZ�b�g
            v_error_message := sqlerrm;
            v_error_stack := dbms_utility.format_error_stack;
            v_error_backtrace := dbms_utility.format_error_backtrace;
            -- �G���[�����o��
            -- fnc.disp_out('�G���[: ' || v_error_message);
            fnc.disp_out('�G���[�X�^�b�N: ' || v_error_stack);
            fnc.disp_out('�G���[������: ' || v_error_backtrace);
            edi_debug_log('�G���[�X�^�b�N: ' || v_error_stack);
            edi_debug_log('�G���[������: ' || v_error_backtrace);
    end err_disp;

end lib_edi;
/

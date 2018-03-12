'==============================
'DML쿼리 performance test - setting
'==============================
sub GIT_CLONE_PENTAQA_AUTOTEST	
	call LoginPutty2 'putty 실행
	call unit_execute_command("putty",DB_IP,"Putty","git clone https://github.com/pentaqa/autotest.git") 'git clone benchmark
	end sub

sub DML_QUERY_PERFORMANCE_SET_CUSTOMER_DATA 	
	call Log.picture(sys.Desktop,"-----DML 쿼리 성능 테스트")
		LogFolder = Log.CreateFolder("customer table 준비")
		Log.PushLogFolder(LogFolder)
	call unit_execute_command("putty",DB_IP,"Putty","cd /autotest/benchmark/dbgen/bin/2.7.13/dbgen/"&"[Enter]") 'dbgen경로로 이동
	call unit_execute_command("putty",DB_IP,"Putty","./dbgen -T -c -s 334"&"[Enter]") '5010만건 customer data생성
end sub


sub DML_QUERY_PERFORMANCE_SET_CUSTOMER_TABLE
	call LoginPutty2 'putty 실행
	if DB_INFO = "DE-MYQ" then
		call UNITS_EXEC_CREATE_TABLE_SCRIPT(strTableName,array(""),array("init_testdb_myq.sql")	'db_info = mysql일 때, drop test db > create test tb > create customer table
		call unit_execute_command("putty",DB_IP,"Putty","mysql -uroot -pQaeldkah9./ test"&"[Enter]") '
		'LOAD DATA
	end if
	else if DB_INFO = "postgres" then
		call UNITS_EXEC_CREATE_TABLE_SCRIPT(strTableName,array(""),array("init_testdb_pgs.sql") 'db_info = psql일 때, drop test db > create test tb > create customer table
		'copy data
	end if
end sub





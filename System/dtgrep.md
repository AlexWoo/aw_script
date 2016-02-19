# dtgrep
---
## Instructions

grep in files under directory and it's sub directory

## Usage

You can use this script as follow

	./dtgrep dirpath [options] PATTERN

options and PATTERN are same with grep

## example

- grep debug in files under nginx-development/ngx_tcpclient_module

		[root@123 ~]# ./dtgrep nginx-development/ngx_tcpclient_module debug
		
		nginx-development/ngx_tcpclient_module/src/ngx_httpc_request.c:
		            ngx_log_debug1(NGX_LOG_DEBUG_HTTP, tc->log, 0,
		            ngx_log_debug1(NGX_LOG_DEBUG_HTTP, tc->log, 0,
		            ngx_log_debug2(NGX_LOG_DEBUG_HTTP, r->connection->log, 0,
		            ngx_log_debug0(NGX_LOG_DEBUG_HTTP, r->connection->log, 0,
		    ngx_log_debug0(NGX_LOG_DEBUG_HTTP, r->connection->log, 0,
		    ngx_log_debug0(NGX_LOG_DEBUG_HTTP, r->connection->log, 0,
		
		nginx-development/ngx_tcpclient_module/src/ngx_tcpclient_core.c:
		    ngx_log_debug1(NGX_LOG_DEBUG_TCPCLIENT, tc->log, 0,
		    ngx_log_debug1(NGX_LOG_DEBUG_TCPCLIENT, tc->log, 0,
		    ngx_log_debug1(NGX_LOG_DEBUG_TCPCLIENT, tc->log, 0,
		    ngx_log_debug6(NGX_LOG_DEBUG_TCPCLIENT, tc->log, 0,
		                ngx_log_debug1(NGX_LOG_DEBUG_TCPCLIENT, tc->log, 0,
		            ngx_log_debug2(NGX_LOG_DEBUG_TCPCLIENT, tc->log, 0,
		    ngx_log_debug6(NGX_LOG_DEBUG_TCPCLIENT, tc->log, 0,
		    ngx_log_debug6(NGX_LOG_DEBUG_TCPCLIENT, tc->log, 0,
		    ngx_log_debug6(NGX_LOG_DEBUG_TCPCLIENT, tc->log, 0,
		    ngx_log_debug1(NGX_LOG_DEBUG_TCPCLIENT, tc->log, 0,
		    ngx_log_debug0(NGX_LOG_DEBUG_TCPCLIENT, tc->log, 0,
		    ngx_log_debug0(NGX_LOG_DEBUG_TCPCLIENT, tc->log, 0,
		    ngx_log_debug1(NGX_LOG_DEBUG_TCPCLIENT, tc->log, 0,
		    ngx_log_debug0(NGX_LOG_DEBUG_TCPCLIENT, tc->log, 0,
		    ngx_log_debug0(NGX_LOG_DEBUG_TCPCLIENT, tc->log, 0,
		    ngx_log_debug0(NGX_LOG_DEBUG_CORE, tc->log, 0,
		    ngx_log_debug0(NGX_LOG_DEBUG_TCPCLIENT, tc->log, 0,
		        ngx_log_debug0(NGX_LOG_DEBUG_TCPCLIENT, tc->log, 0,
		            ngx_log_debug0(NGX_LOG_DEBUG_TCPCLIENT, tc->log, 0,
		        ngx_log_debug6(NGX_LOG_DEBUG_TCPCLIENT, tc->log, 0,
		        ngx_log_debug1(NGX_LOG_DEBUG_TCPCLIENT, tc->log, 0,
		                ngx_log_debug2(NGX_LOG_DEBUG_TCPCLIENT, tc->log, 0,
		                ngx_log_debug0(NGX_LOG_DEBUG_TCPCLIENT, tc->log, 0,
		    ngx_log_debug0(NGX_LOG_DEBUG_TCPCLIENT, tc->log, 0,
		        ngx_log_debug0(NGX_LOG_DEBUG_TCPCLIENT, tc->log, 0,
		    ngx_log_debug(NGX_LOG_DEBUG_TCPCLIENT, c->log, 0,
		    ngx_log_debug0(NGX_LOG_DEBUG_CORE, wev->log, 0,
		    ngx_log_debug0(NGX_LOG_DEBUG_TCPCLIENT, tc->log, 0,
		    ngx_log_debug0(NGX_LOG_DEBUG_CORE, tc->log, 0,
		
		nginx-development/ngx_tcpclient_module/src/ngx_httpc_response_body.c:
		        ngx_log_debug1(NGX_LOG_DEBUG_HTTP, r->connection->log, 0,
		    ngx_log_debug0(NGX_LOG_DEBUG_HTTP, c->log, 0,
		            ngx_log_debug1(NGX_LOG_DEBUG_HTTP, c->log, 0,
		        ngx_log_debug1(NGX_LOG_DEBUG_HTTP, c->log, 0,
		        ngx_log_debug0(NGX_LOG_DEBUG_HTTP, r->connection->log, 0,
		        ngx_log_debug0(NGX_LOG_DEBUG_HTTP, r->connection->log, 0,
		            ngx_log_debug7(NGX_LOG_DEBUG_EVENT, r->connection->log, 0,
		[root@123 ~]# 

- grep debug in files under nginx-development/ngx_tcpclient_module with file line

		[root@123 ~]# ./dtgrep nginx-development/ngx_tcpclient_module -n debug
		
		nginx-development/ngx_tcpclient_module/src/ngx_httpc_request.c:
		698:            ngx_log_debug1(NGX_LOG_DEBUG_HTTP, tc->log, 0,
		703:            ngx_log_debug1(NGX_LOG_DEBUG_HTTP, tc->log, 0,
		789:            ngx_log_debug2(NGX_LOG_DEBUG_HTTP, r->connection->log, 0,
		798:            ngx_log_debug0(NGX_LOG_DEBUG_HTTP, r->connection->log, 0,
		970:    ngx_log_debug0(NGX_LOG_DEBUG_HTTP, r->connection->log, 0,
		979:    ngx_log_debug0(NGX_LOG_DEBUG_HTTP, r->connection->log, 0,
		
		nginx-development/ngx_tcpclient_module/src/ngx_tcpclient_core.c:
		295:    ngx_log_debug1(NGX_LOG_DEBUG_TCPCLIENT, tc->log, 0,
		313:    ngx_log_debug1(NGX_LOG_DEBUG_TCPCLIENT, tc->log, 0,
		342:    ngx_log_debug1(NGX_LOG_DEBUG_TCPCLIENT, tc->log, 0,
		355:    ngx_log_debug6(NGX_LOG_DEBUG_TCPCLIENT, tc->log, 0,
		414:                ngx_log_debug1(NGX_LOG_DEBUG_TCPCLIENT, tc->log, 0,
		421:            ngx_log_debug2(NGX_LOG_DEBUG_TCPCLIENT, tc->log, 0,
		440:    ngx_log_debug6(NGX_LOG_DEBUG_TCPCLIENT, tc->log, 0,
		451:    ngx_log_debug6(NGX_LOG_DEBUG_TCPCLIENT, tc->log, 0,
		467:    ngx_log_debug6(NGX_LOG_DEBUG_TCPCLIENT, tc->log, 0,
		551:    ngx_log_debug1(NGX_LOG_DEBUG_TCPCLIENT, tc->log, 0,
		566:    ngx_log_debug0(NGX_LOG_DEBUG_TCPCLIENT, tc->log, 0,
		614:    ngx_log_debug0(NGX_LOG_DEBUG_TCPCLIENT, tc->log, 0,
		673:    ngx_log_debug1(NGX_LOG_DEBUG_TCPCLIENT, tc->log, 0,
		772:    ngx_log_debug0(NGX_LOG_DEBUG_TCPCLIENT, tc->log, 0,
		796:    ngx_log_debug0(NGX_LOG_DEBUG_TCPCLIENT, tc->log, 0,
		964:    ngx_log_debug0(NGX_LOG_DEBUG_CORE, tc->log, 0,
		1012:    ngx_log_debug0(NGX_LOG_DEBUG_TCPCLIENT, tc->log, 0,
		1018:        ngx_log_debug0(NGX_LOG_DEBUG_TCPCLIENT, tc->log, 0,
		1058:            ngx_log_debug0(NGX_LOG_DEBUG_TCPCLIENT, tc->log, 0,
		1074:        ngx_log_debug6(NGX_LOG_DEBUG_TCPCLIENT, tc->log, 0,
		1083:        ngx_log_debug1(NGX_LOG_DEBUG_TCPCLIENT, tc->log, 0,
		1095:                ngx_log_debug2(NGX_LOG_DEBUG_TCPCLIENT, tc->log, 0,
		1102:                ngx_log_debug0(NGX_LOG_DEBUG_TCPCLIENT, tc->log, 0,
		1159:    ngx_log_debug0(NGX_LOG_DEBUG_TCPCLIENT, tc->log, 0,
		1164:        ngx_log_debug0(NGX_LOG_DEBUG_TCPCLIENT, tc->log, 0,
		1204:    ngx_log_debug(NGX_LOG_DEBUG_TCPCLIENT, c->log, 0,
		1221:    ngx_log_debug0(NGX_LOG_DEBUG_CORE, wev->log, 0,
		1236:    ngx_log_debug0(NGX_LOG_DEBUG_TCPCLIENT, tc->log, 0,
		1261:    ngx_log_debug0(NGX_LOG_DEBUG_CORE, tc->log, 0,
		
		nginx-development/ngx_tcpclient_module/src/ngx_httpc_response_body.c:
		48:        ngx_log_debug1(NGX_LOG_DEBUG_HTTP, r->connection->log, 0,
		182:    ngx_log_debug0(NGX_LOG_DEBUG_HTTP, c->log, 0,
		242:            ngx_log_debug1(NGX_LOG_DEBUG_HTTP, c->log, 0,
		284:        ngx_log_debug1(NGX_LOG_DEBUG_HTTP, c->log, 0,
		405:        ngx_log_debug0(NGX_LOG_DEBUG_HTTP, r->connection->log, 0,
		477:        ngx_log_debug0(NGX_LOG_DEBUG_HTTP, r->connection->log, 0,
		496:            ngx_log_debug7(NGX_LOG_DEBUG_EVENT, r->connection->log, 0,
		[root@123 ~]# 

- grep line start with print in files under luaffi with file line

		[root@123 ~]# ./dtgrep luaffi/ -n "^print"
		
		luaffi/t.lua:
		10:print(a)
		
		luaffi/ffi.lua:
		2:print(package.cpath)
		[root@123 ~]#

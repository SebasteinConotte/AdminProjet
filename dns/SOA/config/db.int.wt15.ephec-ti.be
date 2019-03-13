$ORIGIN wt15.ephec-ti.be.
$TTL	43200
@	IN	SOA	ns.wt15.ephec-ti.be. admin.wt15.ephec-ti.be. (
		 	2018050401	; Serial
			 43200		; Refresh
			  7200		; Retry
			2419200		; Expire
			  43200 )	; Negative Cache TTL
;
; name servers - NS record
@				IN	NS			ns.wt15.ephec-ti.be.



; name servers - A record
ns 				    IN	A		51.77.203.87

; web services
serverWeb			IN	A		51.77.203.87
www				    IN	CNAME	 	serverWeb
b2b				    IN	CNAME		serverWeb
intranet			IN	CNAME		serverWeb

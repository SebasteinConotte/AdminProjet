$ORIGIN w15.ephec-ti.be.
$TTL	43200
@	IN	SOA	ns.w15.ephec-ti.be. admin.w15.ephec-ti.be. (
		 	2018050401	; Serial
			 43200		; Refresh
			  7200		; Retry
			2419200		; Expire
			  43200 )	; Negative Cache TTL
;
; name servers - NS record
@				IN	NS			ns.w15.ephec-ti.be.
@				IN 	MX 			10	mail


; name servers - A record
ns 				    IN	A		51.77.203.87

; web services
serverWeb			IN	A		51.77.203.87
www				    IN	CNAME	 	serverWeb
b2b				    IN	CNAME		serverWeb

; mail services
mail					IN 	A		51.77.203.89
smtp					IN	CNAME	mail
pop3					IN	CNAME	mail
imap					IN	CNAME	mail
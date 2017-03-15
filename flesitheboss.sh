#!/bin/bash

salir="0"
while [ "$salir" != 1 ];
do
	clear
	echo "
	################## # FLESI THE BOSS # ##################

	1. Redes
	2. DNS
	3. DHCP
	4. APACHE [ WORKING... ] 20%
	5. Correo [ WORKING... ] 75%
	6. LDAP [ WORKING... ] 90%
	7. NFS [ WORKING... ] 10%
	8. Samba [ WORKING... ] 5%
	
	9.Salir
	0.ACTUALIZAR
	
		10. AGRADECIMIENTOS!!

	## Alpha ##################################### ver.1.9 ##
	"
	echo -n "Selecciona una opcion: "
        read opc

        case $opc in
            1) #REDES
			clear
				echo "
		################## # REDES # ##################

		1. Configurar interfaces y rutas
		2. Configurar iptables

		################################################
				"
				echo -n "Selecciona una opcion: "
					read redesopc
						case $redesopc in
							1) # CONFIGURAR INTERFAZ DE RED
							clear
								sed -e '10,11 d' /etc/network/interfaces
								contador=0
								echo -n "Escriba el numero de interfaces: "
									read numinterfaz
									while [ $contador != $numinterfaz ]
									do
										clear
										echo "1. DHCP"
										echo "2. STATIC"
										echo ""
										echo -n "Selecciona el tipo de interfaz para eth$contador: "
											read opcinterfaz
												case $opcinterfaz in
													1) # INTERFAZ DHCP
														echo "# eth$contador interface"	>>  /etc/network/interfaces
														echo "auto eth$contador"	>>  /etc/network/interfaces
														echo "iface inet dhcp"	>>  /etc/network/interfaces
														echo " "	>>  /etc/network/interfaces
														echo " "	>>  /etc/network/interfaces
													;; # FIN INTERFAZ DHCP
	
								            		2) # INTERFAZ STATIC
		
														echo -n "Escriba la direccion ip: "
															read address
														echo -n "Escriba la mascara de red: "
															read netmask
		
														echo "# eth$contador interface"	>>  /etc/network/interfaces
														echo "auto eth$contador"	>>  /etc/network/interfaces
														echo "iface inet static"	>>  /etc/network/interfaces
														echo "address $address"	>>  /etc/network/interfaces
														echo "netmask $netmask"	>>  /etc/network/interfaces
		
														echo -n "Tiene esta interface Gateway (Y/N): "
															read gw
																if [ $gw = "Y" ]; then
																	echo -n "Escriba la gateway: "
																		read gateway
																	echo "gateway $gateway     			         "	>>  /etc/network/interfaces
																fi
														echo -n "Añadir rutas? (Y/N): "
															read rutas
																if [ $rutas = "Y" ]; then
																	echo -n "Escriba el numero de rutas a añadir: "
																		read numrutas
																		contador=0
																		while [ $contador != $numrutas ]
																		do
																			echo ""
																			echo -n "Escriba la ip de la red: "
																				read ipred
																			echo -n "Escriba la mascara ( 255.255.255.0 ): "
																				read netmask
																			echo -n "Escriba la gateway: "
																				read gw
																			echo "post-up route add -net $ipred netmask $netmask gw $gw"	>>  /etc/network/interfaces
																		let contador+=1
																		done
																fi
														
														echo " "	>>  /etc/network/interfaces
														echo " "	>>  /etc/network/interfaces
												;; # FIN INTERFAZ STATIC
											esac
									let contador+=1
									done
			            	;; # FIN CONFIGURAR INTERFAZ DE RED

							2) # IP TABLES
							clear
								#BORRAMOS LA LINEA FINAL (exit 0)
								sed -e '14 d' /etc/rc.local
								echo "iptables -t nat -F">>  /etc/rc.local
								echo "iptables -t nat -X">>  /etc/rc.local
								echo "iptables -F">>  /etc/rc.local
								echo "iptables -X">>  /etc/rc.local
									echo -n "Escriba el numero de redes:"
										read numredes
										contador=0
										while [ $contador != $numredes ]
										do
											echo ""
											echo -n "Escriba la ip de la red: "
												read ipred
											echo -n "Escriba la mascara ( 24 ): "
												read mascara
											echo -n "Escriba la interface de salida ( eth0 ): "
												read ioutput
											echo "iptables -t nat -A POSTROUTING -s $ipred/$mascara -o $ioutput -j MASQUERADE"  >>  /etc/rc.local
										let contador+=1
										done
								# AÑADIMOS LA LINEA FINAL (exit 0)
								echo "exit 0"	>>  /etc/rc.local
							;; # FIN CONFIGURAR IPTABLES
						esac
			;; # FIN REDES

			2) #DNS
			clear
				 echo "
				 #############################
				 
				   1. MAESTRO
				   2. ESCLAVO
				   3. DELEGADO
				   4. CACHE
				   
				   0. INSTALAR
				   9. REINICIAR
				   
				 #############################
				 "
				 echo -n "Seleccione una opcion: "
					read menu0
						case $menu0 in
							1) # MAESTRO
							clear
								echo "
								############################
								
								1. DIRECTO
								2. INVERSO
								
								############################
								"
								echo -n "Seleccione una opcion: "
									read menu1
										case $menu1 in
											1) # MAESTRO DIRECTO
											clear
												echo -n "Escriba su zona (flesitheboss.com): "
													read zona
													echo " "
												echo -n "Escriba el nombre del equipo actual (serverdns): "
													read equipo
												echo -n "Escriba la ip del equipo actual: "
													read ipequipo
														echo ";" >>  /etc/bind/db.$zona
														echo "; BIND data file for local loopback interface" >>  /etc/bind/db.$zona
														echo ";" >>  /etc/bind/db.$zona
														echo "$TTL      604800" >>  /etc/bind/db.$zona
														echo "@         IN      SOA         $equipo.$zona. $equipo.$zona. (" >>  /etc/bind/db.$zona
														echo "                               1        ; Serial" >>  /etc/bind/db.$zona
														echo "                          604800        ; Refresh" >>  /etc/bind/db.$zona
														echo "                          86400         ; Retry" >>  /etc/bind/db.$zona
														echo "                          2419200       ; Expire" >>  /etc/bind/db.$zona
														echo "                          604800 )      ; Negative Cache TTL" >>  /etc/bind/db.$zona
														echo ";" >>  /etc/bind/db.$zona
														echo "@         IN        NS    	$equipo.$zona." >>  /etc/bind/db.$zona
														echo "@         IN        A			$ipequipo" >>  /etc/bind/db.$zona
							                                echo " "
							                                echo " "
															echo -n "Escriba el numero de equipos: "
																read numredes
																	contador=0
																	while [ $contador != $numredes ]
																	do
																		echo " "
																		echo -n "Escriba el nombre del equipo$contador (equip$contador): "
																			read nombrerequipo
																				equip[$contador]="$nombrerequipo"
								
																			echo -n "Escriba la ip del equipo$contador (192.168.1.1): "
							    												read ipequipo
								    												ipequip[$contador]="$ipequipo"
																		echo "${equip[$contador]}       IN      A     ${ipequip[$contador]}" >>  /etc/bind/db.$zona
							
																	let contador+=1
																	done
															clear
															echo -n "Desea agregar una delegacion? (Y/N): "
																read delegacionopc
																	if [ $delegacionopc = "Y" ]; then
																		echo -n "Cuantas delegaciones desea añadir?:"
																			read ndelega
																		contador=0
																		while [ "$contador" != "$ndelega" ]
																		do
																			echo -n "Escriba la delegacion (delegacion1): "
																				read delegacion
																			echo ""
																			echo -n "Escriba el equipo delegado (equipdelegado1): "
																				read equipodelegado
																			echo -n "Escriba la ip del equipo delegado (10.0.0.2): "
																				read ipequipodelegado
																			echo ""
																			echo ""
																					echo ""	>>  /etc/bind/db.$zona
																					echo "\$ORIGIN $delegacion.$zona."	>>  /etc/bind/db.$zona
																					echo "@		IN	NS	$equipodelegado.$delegacion.$zona."	>>  /etc/bind/db.$zona
																					echo "@		IN	A	$ipequipodelegado"	>>  /etc/bind/db.$zona
																		let contador+=1
																		done
																	fi
												#AÑADIMOS LA ZONA A NAMED.CONF.LOCAL
												echo -n "Escriba la IP del dns esclavo: "
													read ipdnsslave
														echo "zone \"$zona\" {" >>  /etc/bind/named.conf.local
														echo "	type master;" >>  /etc/bind/named.conf.local
														echo "	file \"/etc/bind/db.$zona\";" >>  /etc/bind/named.conf.local
														echo "	also-notify { $ipdnsslave };" >>  /etc/bind/named.conf.local
														echo "	forwarders {};" >>  /etc/bind/named.conf.local
														echo "};" >>  /etc/bind/named.conf.local
												
											;; # FIN MAESTRO DIRECTO
											
											2) # MAESTRO INVERSO
												echo -n "Escriba el numero de zonas inversas: "
													read numzonas
														contador=0
														while [ $contador != $numzonas ]
														do	
															clear
															echo -n "Escriba la zona (flesitheboss.com): "
																read zona
															echo -n "Escriba el nombre del equipo actual (serverdns): "
																read equipo
															echo -n "Escriba ip de zona inversa (Para red 192.168.1.0 = 1.168.192): "
																read zonainversa
																	echo ";" >>  /etc/bind/db.$zonainversa
																	echo "; BIND data file for local loopback interface" >>  /etc/bind/db.$zonainversa
																	echo ";" >>  /etc/bind/db.$zonainversa
																	echo "$TTL		604800" >>  /etc/bind/db.$zonainversa
																	echo "@       IN      SOA     $equipo.$zona. $equipo.$zona. (" >>  /etc/bind/db.$zonainversa
																	echo "                              1         ; Serial" >>  /etc/bind/db.$zonainversa
																	echo "                         604800         ; Refresh" >>  /etc/bind/db.$zonainversa
																	echo "                          86400         ; Retry" >>  /etc/bind/db.$zonainversa
																	echo "                        2419200         ; Expire" >>  /etc/bind/db.$zonainversa
																	echo "                         604800 )       ; Negative Cache TTL" >>  /etc/bind/db.$zonainversa
																	echo ";" >>  /etc/bind/db.$zonainversa
																	echo "@       IN      NS      $equipo.$zona." >>  /etc/bind/db.$zonainversa
							
																		echo -n "Escriba el numero de equipos: "
																			read numequip
																				conta=0
																					while [ $conta != $numequip ]
																						do	
																						echo " "
																							echo -n "Escriba el nombre del equipo$conta (equip$conta): "
																								read nombrerequipo
																									equip[$conta]="$nombrerequipo"
							
																							echo -n "Escriba el final de su ip 192.168.100.1 ($conta): "
																								read ipequipo
																									ipequip[$conta]="$ipequipo"
							
																							echo "${ipequip[$conta]}       IN      PTR		${equip[$conta]}" >>  /etc/bind/db.$zonainversa
																						let conta+=1
																						done
														let contador+=1
														done
													# AÑADIMOS LA ZONAS  INVERSA A NAMED.CONF.LOCAL					
													contador=0
													while [ $contador != $numzonas ]
													do
														echo -n "Escriba la IP del dns esclavo: "
															read ipdnsslave
																echo "zone \"$zonainversa.in-addr.arpa\" {" >>  /etc/bind/named.conf.local
																echo "	type master;" >>  /etc/bind/named.conf.local
																echo "	file \"/etc/bind/db.$zonainversa\";" >>  /etc/bind/named.conf.local
																echo "	also-notify { $ipdnsslave };" >>  /etc/bind/named.conf.local
																echo "	forwarders {};" >>  /etc/bind/named.conf.local
																echo "};" >>  /etc/bind/named.conf.local
													let contador+=1
													done
											
											;; # FIN MAESTRO INVERSO
										esac
							;; # FIN MAESTRO
							
							2) # ESCLAVO
							clear
								echo "
								############################
								
								1. DIRECTO
								2. INVERSO
								
								############################
								"
								echo -n "Seleccione una opcion: "
									read menu2
										case $menu2 in
											1) # ESCLAVO DIRECTO
												clear
													echo - "Escriba la zona (flesitheboss.com): "
														read zona
													echo -n "Escriba la IP del dns maestro: "
														read ipdnsmaster
															echo "zone \"$zona\" {" >>  /etc/bind/named.conf.local
															echo "	type slave;" >>  /etc/bind/named.conf.local
															echo "	file \"/var/cache/bind/db.$zona\";" >>  /etc/bind/named.conf.local
															echo "	masters { $ipdnsmaster };" >>  /etc/bind/named.conf.local
															echo "	forwarders {};" >>  /etc/bind/named.conf.local
															echo "};"  >>  /etc/bind/named.conf.local
											;; # FIN ESCLAVO DIRECTO
											
											2) # ESCLAVO INVERSO
												clear
													echo -n "Escriba el numero de zonas inversas: "
														read numzonas
															contador=0
															while [ $contador != $numzonas ]
															do
																echo -n "Escriba ip de zona inversa (Para red 192.168.1.0 = 1.168.192): "
																	read zonainversa
				
																echo -n "Escriba la IP del dns maestro: "
																	read ipdnsmaster
				
																		echo "zone \"$zonainversa.in-addr.arpa\" {" >>  /etc/bind/named.conf.local
																		echo "	type master;" >>  /etc/bind/named.conf.local
																		echo "	file \"/etc/bind/db.$zonainversa\";" >>  /etc/bind/named.conf.local
																		echo "	also-notify { $ipdnsmaster };" >>  /etc/bind/named.conf.local
																		echo "	forwarders {};" >>  /etc/bind/named.conf.local
																		echo "};" >>  /etc/bind/named.conf.local
															let contador+=1
															done
											;; # FIN ESCLAVO INVERSO
										esac
							;; # FIN ESCLAVO
							
							3) # DELEGADO
								clear
									echo -n "Escriba su zon (flesitheboss.com): "
										read zona
									echo -n "Escriba su delegacion (delegacion1): "
										read delegacion
									echo -n "Escriba el nombre del equipo actual (equipdelegado): "
										read equipodelegado
									echo -n "Escriba la ip del equipo delegado: "
										read ipequipodelegado
											echo ";" >>  /etc/bind/db.$delegacion
											echo "; BIND data file for local loopback interface" >>  /etc/bind/db.$delegacion
											echo ";" >>  /etc/bind/db.$delegacion
											echo "$TTL		604800" >>  /etc/bind/db.$delegacion
											echo "@       IN      SOA     $equipodelegado.$delegacion.$zona. $equipodelegado.$delegacion.$zona. (" >>  /etc/bind/db.$delegacion
											echo "                              1         ; Serial" >>  /etc/bind/db.$delegacion
											echo "                         604800         ; Refresh" >>  /etc/bind/db.$delegacion
											echo "                          86400         ; Retry" >>  /etc/bind/db.$delegacion
											echo "                        2419200         ; Expire" >>  /etc/bind/db.$delegacion
											echo "                         604800 )       ; Negative Cache TTL" >>  /etc/bind/db.$delegacion
				    						echo ";" >>  /etc/bind/db.$delegacion
											echo "@         IN      NS      $equipodelegado.$delegacion.$zona." >>  /etc/bind/db.$delegacion
											echo "@			IN		A		$ipequipodelegado" >>  /etc/bind/db.$delegacion
				
												echo -n "Escriba el numero de equipos: "
													read numredes
														contador=0
														while [ $contador != $numredes ]
														do
															echo -n "Escriba el nombre del equipo$contador (router): "
																read nombrerequipo
																	equip[$contador]="$nombrerequipo"
				
															echo -n "Escriba la ip del equipo (192.168.1.1): "
																read ipequipo
																	ipequip[$contador]="$ipequipo"
				
															echo "${equip[$contador]}       IN      A     ${ipequip[$contador]}" >>  /etc/bind/db.$delegacion
				
														let contador+=1
														done
							;; # FIN DELEGADO
							
							4) # CACHE
							clear
								echo -n "Escriba el forwarder (8.8.8.8): "
									read forwarder
										echo "forwarders {				" >>  /etc/bind/named.conf.options
										echo "		$forwarder;			" >>  /etc/bind/named.conf.options
										echo "}							"  >>  /etc/bind/named.conf.options
										echo "allow-recursion {any;};	"	>>  /etc/bind/named.conf.options
										echo "};						"	>>  /etc/bind/named.conf.options
							;; # FIN CACHE
							
							0) # INSTALAR
							clear
								apt-get install bind9
							;; # FIN INSTALAR
							
							9) # REINICIAR
							clear
								/etc/init.d/bind9 restart
							;; # FIN REINICIAR
						esac
			;; #FIN DNS

			3) # DHCP
				clear
				echo "
				################## # DHCP # ##################

				1. Instalar DHCP Server
				2. Configurar DHCP Server
				3. Instalar DHCP Relay

				#############################################
				"
				echo -n "Selecciona una opcion: "
					read dhcpopc
						case $dhcpopc in
							1) # DHCP - INSTALAR DHCP SERVER
							clear
								apt-get install isc-dhcp-server
							;; # DHCP - FIN INSTALAR DHCP SERVER

							2) # DHCP - CONFIGURAR DHCP SERVER
							clear
								echo -n "Escriba el numero de redes"
									read redes
									contador=0
										while [ $contador != $redes]
										do
											echo -n "Escriba la red (192.168.1.0): "
												read red
											echo -n "Escriba la mascara de red: "
												read -n netmask

											echo "subnet $red netmask $netmask {" >>  /etc/dhcp/dhcpd.conf
											echo "}" >>  /etc/dhcp/dhcpd.conf

												echo -n "Escriba el numero de subredes: "
													read subred

														while [ $contador != $subred ]
														do
															echo -n "Escriba la subred"
															read subred
															echo -n "Escriba la mascara red"
															read netmask
															echo -n "Escriba el rango de inicio"
															read rangeini
															echo -n "Escriba el rango de fin"
															read rangefin
															echo -n "Escriba la ip del dominio dns"
															read dnsserver
															echo -n "Escriba el nombre del dominio dns"
															read domainname
															echo -n "Escriba la puerta de enlace"
															read netmask
															echo "subnet $subred netmask $netmask {" >>  /etc/dhcp/dhcpd.conf
															echo "    range $rangeini $rangefin;" >>  /etc/dhcp/dhcpd.conf
															echo "    option domain-name-servers $dnsserver;" >>  /etc/dhcp/dhcpd.conf
															echo "    option domain-name \"$domainname\";" >>  /etc/dhcp/dhcpd.conf
															echo "    option routers $gateway;" >>  /etc/dhcp/dhcpd.conf
															echo "}" >>  /etc/dhcp/dhcpd.conf
														let contador+=1
														done
										let contador+=1
										done
							;; # DHCP - FIN CONFIGURAR DHCP SERVER

							3) # DHCP - INSTALAR DHCP RELAY
							clear
								apt-get install isc-dhcp-relay
							;; # DHCP - FIN INSTALAR DHCP RELAY
						esac
			;; # FIN DHCP

			4) # APACHE 
			clear
				echo "
				################## # APACHE # ##################

				1. Instalar apache
				2. Habilitar directorio personal

				################################################
				"
				echo -n "Selecciona una opcion: "
					read apacheopc
						case $apacheopc in
							1) # APACHE - INSTALAR APACHE
							clear
								apt-get install apache2
							;; # APACHE - FIN INSTALAR APACHE

							2) # APACHE - HABILITAR DIRECTORIO PERSONAL
							clear
								a2enmod userdir
							;; # APACHE - FIN HABILITAR DIRECTORIO PERSONAL
						esac
			;;

			5) # CORREO
			clear
				echo "
				################## # CORREO # ##################

				1. Instalar POSTFIX
				2. Configurar POSTFIX
				3. Instalar DOVECOT
				4. Configurar DOVECOT
				5. Instalar Squirrelmail
				6. Configurar Squirrelmail

				################################################
				"
				echo -n "Selecciona una opcion: "
					read apacheopc
						case $apacheopc in
							1)  # CORREO - INSTALAR POSTFIX
							clear
								apt-get install postfix
							;; # CORREO - FIN INSTALAR POSTFIX

							2)  # CORREO - CONFIGURAR POSTFIX
							clear
								nano /etc/postfix/main.cfg
							;;  # CORREO - FIN CONFIGURAR POSTFIX

							3)  # CORREO - INSTALAR DOVECOT
							clear
								apt-get install dovecot-imapd dovecot-pop3d dovecto-common
							;;  # CORREO - FIN INSTALAR DOVECOT

							4)  # CORREO - CONFIGURAR DOVECOT 
							clear
								nano /etc/dovecot/conf.d/10-auth.conf
							;;  # CORREO - FIN CONFIGURAR DOVECOT

							5)  # CORREO - INSTALAR SQUIRRELMAIL
							clear
								apt-get install squirrelmail
							;; # CORREO -  FIN INSTALAR SQUIRRELMAIL

							6) # CORREO - CONFIGURAR SQUIRRELMAIL
							clear
								squirrelmail-configure
							;; # CORREO - CONFIGURAR SQUIRRELMAIL
						esac
			;; # FIN CORREO

			6) # LDAP
			clear
				echo "
				################## # LDAP # ##################

				1. Servidor
				2. Cliente

				################################################
				"
				echo -n "Selecciona una opcion: "
					read ldapopc
						case $ldapopc in
							1) # SERVIDOR
								echo "
								########## # SERVER LDAP # ###############
								
								1. Server Perfiles Fijos
								2. Server Perfiles Moviles
								
								###########################################
								"
								echo -n "Selecciona una opcion: "
									read serldapopc
										case $serldapopc in
											1) #S_PERFILES FIJOS
											clear
												echo "
												################## # LDAP # ##################
				
									           	1. Instalar LDAP
												2. Reconfigurar LDAP
												3. Instalar phpldapadmin
												4. Configurar acceso via web
				
												################################################
												"
												echo -n "Selecciona una opcion: "
													read serperfilfijo
													case $serperfilfijo in
														1) # LDAP - INSTALAR LDAP
														clear
															apt-get install slapd ldap-utils
														;; # LDAP - FIN INSTALAR LDAP
				
														2) # LDAP - RECONFIGURAR LDAP
														clear
															dpkg-reconfigure slapd
														;; # LDAP - FIN RECONFIGURAR LDAP
				
														3) # LDAP - INSTALAR PHPLDAPADMIN
														clear
															apt-get install phpldapadmin
														;; # LDAP - FIN INSTALAR PHPLDAPADMIN
				
														4)  # LDAP - CONFIGRAR ACCESO VIA WEB
														clear
															echo "Configurar el acceso vía web en fichero /usr/share/phpldapadmin/config/config.php"
																echo -n "DC [com]"
																	read dc0
																echo -n "DC [folgored]"
																	read dc1
																echo "\$servers->SetValue(‘server’,’base’,array(‘dc=$dc1,dc=$dc0’));" >>  /usr/share/phpldapadmin/config/config.php
				
																echo "\$servers->SetValue(‘login,’bind_id’,’cn=admin,dc=$dc1,dc=$dc0));" >>  /usr/share/phpldapadmin/config/config.php
														;; # LDAP - FIN CONFIGRAR ACCESO VIA WEB
													esac
							        	    ;; # FIN S_PERFILES FIJOS
							        	    
							        	    2) #S_PERFILES MOVILES
											clear
												echo "
												################## # LDAP SERVER MOVIL # ##################
					
												1. Instalar LDAP NFS
												2. Crear directorio
												3. Configurar PAM
					
												################################################
												"
													echo -n "Selecciona una opcion: "
														read serperfilmovil
															case $serperfilmovil in
																1) # LDAP - INSTALAR nfs server
																clear
																	apt-get install nfs-kernel-server
																;;
					
																2) # Crear directorio users
																clear
																	mkdir /home/users
																;;
					
																3) # LDAP - nfsserver
																clear
																	echo "/home/users * (rw,no_root_squash)     "   >> /etc/exports
																;;
															esac
											;; # FIN S_PERFILES MOVILES
							        	esac
							;;    
							
							2) # CLIENTES
							clear	
								echo "
									########## # CLIENTE LDAP # ###############
									
									1. Cliente Perfiles Fijos
									2. Cliente Perfiles Moviles
									
									###########################################
									"
									echo -n "Selecciona una opcion: "
										read clienteldapopc
											case $clienteldapopc in
								1) #C_PERFILES FIJOS
								clear
									echo "
									################## # LDAP CLIENTE FIJO # ##################
	
									1. Instalar LDAP Cliente
									2. Reconfigurar LDAP
									3. Configurar PAM
	
									################################################
									"
									echo -n "Selecciona una opcion: "
										read ldapopc
											case $ldapopc in
												1) # LDAP - INSTALAR LDAP
												clear
													apt-get install libnss-ldap
												;; # FIN LDAP - INSTALAR LDAP
	
												2) # LDAP - RECONFIGURAR LDAP
												clear
													dpkg-reconfigure ldap-auth-config
												;; # FIN LDAP - RECONFIGURAR LDAP
	
												3) # LDAP - CONFIGURAR PAM
												clear
													session required pam_mkhomedir.so skel=/etc/skel umask=0022 >> /etc/pam.d/common-session
												;; # FIN LDAP - CONFIGURAR PAM
											esac
								;; #FIN C_PERFILES FIJOS
								
								2) # C_PERFILES MOVILES
								clear
				        	    	echo "
									################## # LDAP CLIENTE MOVIL # ##################
						           	
									1. Instalar LDAP NFS
									2. Crear directorio
									3. Configurar PAM
		
									################################################
									"
									echo -n "Selecciona una opcion: "
										read ldapopc
											case $ldapopc in
												1) # LDAP - INSTALAR nfs server
												clear
													apt-get install nfs-common portmap
												;; # LDAP - FIN INSTALAR nfs server
	
												2) # Crear directorio users
												clear
													mkdir /home/users
												;; # FIN Crear directorio users
	
												3) # LDAP - nfsserver
												clear
													echo -n "Escriba la IP del server: "
														read ipservernfs
															echo "$ipservernfs:/home/users /home/users nfs defaults 0 0   "   >> /etc/fstab
												;; # FIN LDAP - nfsserver
											esac
								;; #FIN C_PERFILES MOVILES
							esac
							;;
						esac
			;; # FIN LDAP

			7) # NFS
			clear
				echo "
				################## # NFS # ######################

				1. Servidor NFS
				2. Cliente NFS
				
				2. Instalar Clientes NFS
				3. Compartir Directorio
				4. Montar Directorio

				##################################################
				"
				echo -n "Selecciona una opcion: "
					read nfsopc
						case $nfsopc in
							1)
								apt-get install nfs-kernel-server
							;;
							
							2)
								apt-get install nfs-common
							;;
							
							3) 
								
							;;
							
							4)
							;;
						esac
			;; # FIN NFS

			8) # Samba
			clear
				echo "
				################# # Samba # #######################

				1. Instalar Servidor Samba
				2. Instalar Cliente Samba

				###################################################
				"
				echo -n "Selecciona una opcion: "
					read sambaopc
						case $sambaopc in
							1)
							;;
							2)
							;;
						esac
			;; # FIN Samba
			
			9) # SALIR
			clear
				salir="1"
			;; # FIN SALIR
        	10)
        	clear
        		echo "Script Creado por Jose Luis Romero	-	jlromero@protonmail.com"
        		read 
        	;;
			0) #ACTUALIZAR
			clear
				chmod 7777 actualizar.sh
				./actualizar.sh
			;;
		esac
done
									do
										clear
										echo "1. DHCP"
										echo "2. STATIC"
										echo ""
										echo -n "Selecciona el tipo de interfaz para eth$contador: "
											read opcinterfaz
												case $opcinterfaz in
													1) # INTERFAZ DHCP
														echo "# eth$contador interface				    "	>>  /etc/network/interfaces
														echo "auto eth$contador						    "	>>  /etc/network/interfaces
														echo "iface inet dhcp	        			    "	>>  /etc/network/interfaces
														echo "        			    					"	>>  /etc/network/interfaces
														echo "        			    					"	>>  /etc/network/interfaces
													;; # FIN INTERFAZ DHCP
	
								            		2) # INTERFAZ STATIC
		
														echo -n "Escriba la direccion ip: "
															read address
														echo -n "Escriba la mascara de red: "
															read netmask
		
														echo "# eth$contador interface				    "	>>  /etc/network/interfaces
														echo "auto eth$contador						    "	>>  /etc/network/interfaces
														echo "iface inet static 	     			    "	>>  /etc/network/interfaces
														echo "address $address          			    "	>>  /etc/network/interfaces
														echo "netmask $netmask           			    "	>>  /etc/network/interfaces
		
														echo -n "Tiene esta interface Gateway (Y/N): "
															read gw
																if [ $gw = "Y" ]; then
																	echo -n "Escriba la gateway: "
																		read gateway
																	echo "gateway $gateway     			         "	>>  /etc/network/interfaces
																fi
														echo -n "Añadir rutas? (Y/N): "
															read rutas
																if [ $rutas = "Y" ]; then
																	echo -n "Escriba el numero de rutas a añadir: "
																		read numrutas
																		contador=0
																		while [ $contador != $numrutas ]
																		do
																			echo ""
																			echo -n "Escriba la ip de la red: "
																				read ipred
																			echo -n "Escriba la mascara ( 255.255.255.0 ): "
																				read netmask
																			echo -n "Escriba la gateway: "
																				read gw
																			echo "post-up route add -net $ipred netmask $netmask gw $gw"	>>  /etc/network/interfaces
																		let contador+=1
																		done
																fi
														
														echo " "	>>  /etc/network/interfaces
														echo " "	>>  /etc/network/interfaces
												;; # FIN INTERFAZ STATIC
											esac
									let contador+=1
									done
			            	;; # FIN CONFIGURAR INTERFAZ DE RED

							2) # IP TABLES
							clear
								#BORRAMOS LA LINEA FINAL (exit 0)
								sed -e '14 d' /etc/rc.local
								echo "iptables -t nat -F"	>>  /etc/rc.local
								echo "iptables -t nat -X"	>>  /etc/rc.local
								echo "iptables -F"			>>  /etc/rc.local
								echo "iptables -X"			>>  /etc/rc.local
									echo -n "Escriba el numero de redes:"
										read numredes
										contador=0
										while [ $contador != $numredes ]
										do
											echo ""
											echo -n "Escriba la ip de la red: "
												read ipred
											echo -n "Escriba la mascara ( 24 ): "
												read mascara
											echo -n "Escriba la interface de salida ( eth0 ): "
												read ioutput
											echo "iptables -t nat -A POSTROUTING -s $ipred/$mascara -o $ioutput -j MASQUERADE"  >>  /etc/rc.local
										let contador+=1
										done
								# AÑADIMOS LA LINEA FINAL (exit 0)
								echo "exit 0"	>>  /etc/rc.local
							;; # FIN CONFIGURAR IPTABLES
						esac
			;; # FIN REDES

			2) #DNS
			clear
				 echo "
				 #############################
				 
				   1. MAESTRO
				   2. ESCLAVO
				   3. DELEGADO
				   4. CACHE
				   
				   0. INSTALAR
				   9. REINICIAR
				   
				 #############################
				 "
				 echo -n "Seleccione una opcion: "
					read menu0
						case $menu0 in
							1) # MAESTRO
							clear
								echo "
								############################
								
								1. DIRECTO
								2. INVERSO
								
								############################
								"
								echo -n "Seleccione una opcion: "
									read menu1
										case $menu1 in
											1) # MAESTRO DIRECTO
											clear
												echo -n "Escriba su zona (flesitheboss.com): "
													read zona
													echo " "
												echo -n "Escriba el nombre del equipo actual (serverdns): "
													read equipo
												echo -n "Escriba la ip del equipo actual: "
													read ipequipo
														echo ";						    					" >>  /etc/bind/db.$zona
														echo "; BIND data file for local loopback interface	" >>  /etc/bind/db.$zona
														echo ";												" >>  /etc/bind/db.$zona
														echo "$TTL      604800									    		" >>  /etc/bind/db.$zona
														echo "@         IN      SOA         $equipo.$zona. $equipo.$zona. ( " >>  /etc/bind/db.$zona
														echo "                               1        ; Serial		" >>  /etc/bind/db.$zona
														echo "							604800        ; Refresh	" >>  /etc/bind/db.$zona
														echo "							86400         ; Retry		" >>  /etc/bind/db.$zona
														echo "							2419200       ; Expire    " >>  /etc/bind/db.$zona
														echo "							604800 )      ; Negative Cache TTL	" >>  /etc/bind/db.$zona
														echo ";" >>  /etc/bind/db.$zona
														echo "@			IN		NS    	$equipo.$zona.				" >>  /etc/bind/db.$zona
														echo "@			IN		A			$ipequipo                   " >>  /etc/bind/db.$zona
							                                echo " "
							                                echo " "
															echo -n "Escriba el numero de equipos:"
																read numredes
																	contador=0
																	while [ $contador != $numredes ]
																	do
																		echo " "
																		echo -n "Escriba el nombre del equipo$contador (equip$contador): "
																			read nombrerequipo
																				equip[$contador]="$nombrerequipo"
								
																			echo -n "Escriba la ip del equipo$contador (192.168.1.1): "
							    												read ipequipo
								    												ipequip[$contador]="$ipequipo"
																		echo "${equip[$contador]}       IN      A     ${ipequip[$contador]}		" >>  /etc/bind/db.$zona
							
																	let contador+=1
																	done
															clear
															echo -n "Desea agregar una delegacion? (Y/N): "
																read delegacionopc
																	if [ $delegacionopc = "Y" ]; then
																		echo -n "Cuantas delegaciones desea añadir?:"
																			read ndelega
																		contador=0
																		while [ "$contador" != "$ndelega" ]
																		do
																			echo -n "Escriba la delegacion (delegacion1): "
																				read delegacion
																			echo " "
																			echo -n "Escriba el equipo delegado (equipdelegado1): "
																				read equipodelegado
																			echo -n "Escriba la ip del equipo delegado (10.0.0.2): "
																				read ipequipodelegado
																			echo " "
																			echo " "
																					echo "  									"	>>  /etc/bind/db.$zona
																					echo "\$ORIGIN $delegacion.$zona.    			"	>>  /etc/bind/db.$zona
																					echo "@		IN	NS	$equipodelegado.$delegacion.$zona.	"	>>  /etc/bind/db.$zona
																					echo "@		IN	A	$ipequipodelegado			"	>>  /etc/bind/db.$zona
																		let contador+=1
																		done
																	fi
												#AÑADIMOS LA ZONA A NAMED.CONF.LOCAL
												echo -n "Escriba la IP del dns esclavo: "
													read ipdnsslave
														echo "zone \"$zona\" {                        " >>  /etc/bind/named.conf.local
														echo "type master;                            " >>  /etc/bind/named.conf.local
														echo "file \"/etc/bind/db.$zona\";            " >>  /etc/bind/named.conf.local
														echo "also-notify { $ipdnsslave };              " >>  /etc/bind/named.conf.local
														echo "forwarders {};				       	  " >>  /etc/bind/named.conf.local
														echo "};" >>  /etc/bind/named.conf.local
												
											;; # FIN MAESTRO DIRECTO
											
											2) # MAESTRO INVERSO
												echo -n "Escriba el numero de zonas inversas: "
													read numzonas
														contador=0
														while [ $contador != $numzonas ]
														do	
															clear
															echo -n "Escriba la zona (flesitheboss.com): "
																read zona
															echo -n "Escriba el nombre del equipo actual (serverdns): "
																read equipo
															echo -n "Escriba ip de zona inversa (Para red 192.168.1.0 = 1.168.192): "
																read zonainversa
																	echo ";																			" >>  /etc/bind/db.$zonainversa
																	echo "; BIND data file for local loopback interface								" >>  /etc/bind/db.$zonainversa
																	echo ";																			" >>  /etc/bind/db.$zonainversa
																	echo "$TTL		604800															" >>  /etc/bind/db.$zonainversa
																	echo "					@       IN      SOA     $equipo.$zona. $equipo.$zona. ( " >>  /etc/bind/db.$zonainversa
																	echo "                              1         ; Serial							" >>  /etc/bind/db.$zonainversa
																	echo "                         604800         ; Refresh							" >>  /etc/bind/db.$zonainversa
																	echo "                          86400         ; Retry							" >>  /etc/bind/db.$zonainversa
																	echo "                        2419200         ; Expire							" >>  /etc/bind/db.$zonainversa
																	echo "                         604800 )       ; Negative Cache TTL				" >>  /etc/bind/db.$zonainversa
																	echo ";																			" >>  /etc/bind/db.$zonainversa
																	echo "@       IN      NS      $equipo.$zona.										" >>  /etc/bind/db.$zonainversa
							
																		echo -n "Escriba el numero de equipos: "
																			read numequip
																				contador=0
																					while [ $contador != $numequip ]
																						do	
																						echo " "
																							echo -n "Escriba el nombre del equipo$contador (equip$contador): "
																								read nombrerequipo
																									equip[$contador]="$nombrerequipo"
							
																							echo -n "Escriba el final de su ip 192.168.100.1 ($contador): "
																								read ipequipo
																									ipequip[$contador]="$ipequipo"
							
																							echo "${ipequip[$contador]}       IN      PTR		${equip[$contador]}" >>  /etc/bind/db.$zonainversa
																						let contador+=1
																						done
														let contador+=1
														done
													# AÑADIMOS LA ZONAS  INVERSA A NAMED.CONF.LOCAL					
														contador=0
														while [ $contador != $numzonas ]
														do
															echo -n "Escriba la IP del dns esclavo: "
																read ipdnsslave
																	echo "zone \"$zonainversa.in-addr.arpa\" {    " >>  /etc/bind/named.conf.local
																	echo "type master;                            " >>  /etc/bind/named.conf.local
																	echo "file \"/etc/bind/db.$zonainversa\";     " >>  /etc/bind/named.conf.local
																	echo "also-notify { $ipdnsslave };              " >>  /etc/bind/named.conf.local
																	echo "forwarders {};				    	  " >>  /etc/bind/named.conf.local
																	echo "};									  " >>  /etc/bind/named.conf.local
														let contador+=1
														done
											
											;; # FIN MAESTRO INVERSO
										esac
							;; # FIN MAESTRO
							
							2) # ESCLAVO
							clear
								echo "
								############################
								
								1. DIRECTO
								2. INVERSO
								
								############################
								"
								echo -n "Seleccione una opcion: "
									read menu2
										case $menu2 in
											1) # ESCLAVO DIRECTO
												clear
													echo - "Escriba la zona (flesitheboss.com): "
														read zona
													echo -n "Escriba la IP del dns maestro: "
														read ipdnsmaster
															echo "zone \"$zona\" {                        " >>  /etc/bind/named.conf.local
															echo "type slave;                           " >>  /etc/bind/named.conf.local
															echo "file \"/var/cache/bind/db.$zona\";    " >>  /etc/bind/named.conf.local
															echo "masters { $ipdnsmaster };               " >>  /etc/bind/named.conf.local
															echo "forwarders {};				    	" >>  /etc/bind/named.conf.local
															echo "};"  >>  /etc/bind/named.conf.local
											;; # FIN ESCLAVO DIRECTO
											
											2) # ESCLAVO INVERSO
												clear
													echo -n "Escriba el numero de zonas inversas: "
														read numzonas
															contador=0
															while [ $contador != $numzonas ]
															do
																echo -n "Escriba ip de zona inversa (Para red 192.168.1.0 = 1.168.192): "
																	read zonainversa
				
																echo -n "Escriba la IP del dns maestro: "
																	read ipdnsmaster
				
																		echo "zone \"$zonainversa.in-addr.arpa\" {   " >>  /etc/bind/named.conf.local
																		echo "type master;                           " >>  /etc/bind/named.conf.local
																		echo "file \"/etc/bind/db.$zonainversa\";    " >>  /etc/bind/named.conf.local
																		echo "also-notify { $ipdnsmaster };            " >>  /etc/bind/named.conf.local
																		echo "forwarders {};				    	 " >>  /etc/bind/named.conf.local
																		echo "};									 " >>  /etc/bind/named.conf.local
															let contador+=1
															done
											;; # FIN ESCLAVO INVERSO
										esac
							;; # FIN ESCLAVO
							
							3) # DELEGADO
								clear
									echo -n "Escriba su zona (flesitheboss.com): "
										read zona
									echo -n "Escriba su delegacion (delegacion1): "
										read delegacion
									echo -n "Escriba el nombre del equipo actual (equipdelegado): "
										read equipodelegado
									echo -n "Escriba la ip del equipo delegado: "
										read ipequipodelegado
											echo ";" >>  /etc/bind/db.$delegacion
											echo "; BIND data file for local loopback interface" >>  /etc/bind/db.$delegacion
											echo ";" >>  /etc/bind/db.$delegacion
											echo "$TTL		604800" >>  /etc/bind/db.$delegacion
											echo "@       IN      SOA     $equipodelegado.$delegacion.$zona. $equipodelegado.$delegacion.$zona. (" >>  /etc/bind/db.$delegacion
											echo "                              1         ; Serial" >>  /etc/bind/db.$delegacion
											echo "                         604800         ; Refresh" >>  /etc/bind/db.$delegacion
											echo "                          86400         ; Retry" >>  /etc/bind/db.$delegacion
											echo "                        2419200         ; Expire" >>  /etc/bind/db.$delegacion
											echo "                         604800 )       ; Negative Cache TTL" >>  /etc/bind/db.$delegacion
				    						echo ";" >>  /etc/bind/db.$delegacion
											echo "@         IN      NS      $equipodelegado.$delegacion.$zona." >>  /etc/bind/db.$delegacion
											echo "@			IN		A		$ipequipodelegado" >>  /etc/bind/db.$delegacion
				
												echo -n "Escriba el numero de equipos: "
													read numredes
														contador=0
														while [ $contador != $numredes ]
														do
															echo -n "Escriba el nombre del equipo$contador (router): "
																read nombrerequipo
																	equip[$contador]="$nombrerequipo"
				
															echo -n "Escriba la ip del equipo (192.168.1.1): "
																read ipequipo
																	ipequip[$contador]="$ipequipo"
				
															echo "${equip[$contador]}       IN      A     ${ipequip[$contador]}		" >>  /etc/bind/db.$delegacion
				
														let contador+=1
														done
							;; # FIN DELEGADO
							
							4) # CACHE
							clear
								sed -e '21 d' /etc/bind/named.conf.options
								sed -e '25 d' /etc/bind/named.conf.options
								echo -n "Escriba el forwarder (8.8.8.8): "
									read forwarder
										echo "forwarders {				" >>  /etc/bind/named.conf.options
										echo "		$forwarder;			" >>  /etc/bind/named.conf.options
										echo "}							"  >>  /etc/bind/named.conf.options
										echo "allow-recursion {any;};	"	>>  /etc/bind/named.conf.options
										echo "};						"	>>  /etc/bind/named.conf.options
							;; # FIN CACHE
							
							0) # INSTALAR
							clear
								apt-get install bind9
							;; # FIN INSTALAR
							
							9) # REINICIAR
							clear
								/etc/init.d/bind9 restart
							;; # FIN REINICIAR
						esac
			;; #FIN DNS

			3) # DHCP
				clear
				echo "
				################## # DHCP # ##################

				1. Instalar DHCP Server
				2. Configurar DHCP Server
				3. Instalar DHCP Relay

				#############################################
				"
				echo -n "Selecciona una opcion: "
					read dhcpopc
						case $dhcpopc in
							1) # DHCP - INSTALAR DHCP SERVER
							clear
								apt-get install isc-dhcp-server
							;; # DHCP - FIN INSTALAR DHCP SERVER

							2) # DHCP - CONFIGURAR DHCP SERVER
							clear
								echo -n "Escriba el numero de redes"
									read redes
									contador=0
										while [ $contador != $redes]
										do
											echo -n "Escriba la red (192.168.1.0): "
												read red
											echo -n "Escriba la mascara de red: "
												read -n netmask

											echo "subnet $red netmask $netmask {" >>  /etc/dhcp/dhcpd.conf
											echo "}" >>  /etc/dhcp/dhcpd.conf

												echo -n "Escriba el numero de subredes: "
													read subred

														while [ $contador != $subred ]
														do
															echo -n "Escriba la subred"
															read subred
															echo -n "Escriba la mascara red"
															read netmask
															echo -n "Escriba el rango de inicio"
															read rangeini
															echo -n "Escriba el rango de fin"
															read rangefin
															echo -n "Escriba la ip del dominio dns"
															read dnsserver
															echo -n "Escriba el nombre del dominio dns"
															read domainname
															echo -n "Escriba la puerta de enlace"
															read netmask
															echo "subnet $subred netmask $netmask {" >>  /etc/dhcp/dhcpd.conf
															echo "    range $rangeini $rangefin;" >>  /etc/dhcp/dhcpd.conf
															echo "    option domain-name-servers $dnsserver;" >>  /etc/dhcp/dhcpd.conf
															echo "    option domain-name \"$domainname\";" >>  /etc/dhcp/dhcpd.conf
															echo "    option routers $gateway;" >>  /etc/dhcp/dhcpd.conf
															echo "}" >>  /etc/dhcp/dhcpd.conf
														let contador+=1
														done
										let contador+=1
										done
							;; # DHCP - FIN CONFIGURAR DHCP SERVER

							3) # DHCP - INSTALAR DHCP RELAY
							clear
								apt-get install isc-dhcp-relay
							;; # DHCP - FIN INSTALAR DHCP RELAY
						esac
			;; # FIN DHCP

			4) # APACHE 
			clear
				echo "
				################## # APACHE # ##################

				1. Instalar apache
				2. Habilitar directorio personal

				################################################
				"
				echo -n "Selecciona una opcion: "
					read apacheopc
						case $apacheopc in
							1) # APACHE - INSTALAR APACHE
							clear
								apt-get install apache2
							;; # APACHE - FIN INSTALAR APACHE

							2) # APACHE - HABILITAR DIRECTORIO PERSONAL
							clear
								a2enmod userdir
							;; # APACHE - FIN HABILITAR DIRECTORIO PERSONAL
						esac
			;;

			5) # CORREO
			clear
				echo "
				################## # CORREO # ##################

				1. Instalar POSTFIX
				2. Configurar POSTFIX
				3. Instalar DOVECOT
				4. Configurar DOVECOT
				5. Instalar Squirrelmail
				6. Configurar Squirrelmail

				################################################
				"
				echo -n "Selecciona una opcion: "
					read apacheopc
						case $apacheopc in
							1)  # CORREO - INSTALAR POSTFIX
							clear
								apt-get install postfix
							;; # CORREO - FIN INSTALAR POSTFIX

							2)  # CORREO - CONFIGURAR POSTFIX
							clear
								nano /etc/postfix/main.cfg
							;;  # CORREO - FIN CONFIGURAR POSTFIX

							3)  # CORREO - INSTALAR DOVECOT
							clear
								apt-get install dovecot-imapd dovecot-pop3d dovecto-common
							;;  # CORREO - FIN INSTALAR DOVECOT

							4)  # CORREO - CONFIGURAR DOVECOT 
							clear
								nano /etc/dovecot/conf.d/10-auth.conf
							;;  # CORREO - FIN CONFIGURAR DOVECOT

							5)  # CORREO - INSTALAR SQUIRRELMAIL
							clear
								apt-get install squirrelmail
							;; # CORREO -  FIN INSTALAR SQUIRRELMAIL

							6) # CORREO - CONFIGURAR SQUIRRELMAIL
							clear
								squirrelmail-configure
							;; # CORREO - CONFIGURAR SQUIRRELMAIL
						esac
			;; # FIN CORREO

			6) # LDAP
			clear
				echo "
				################## # LDAP # ##################

				1. Servidor
				2. Cliente

				################################################
				"
				echo -n "Selecciona una opcion: "
					read ldapopc
						case $ldapopc in
							1) # SERVIDOR
								echo "
								########## # SERVER LDAP # ###############
								
								1. Server Perfiles Fijos
								2. Server Perfiles Moviles
								
								###########################################
								"
								echo -n "Selecciona una opcion: "
									read serldapopc
										case $serldapopc in
											1) #S_PERFILES FIJOS
											clear
												echo "
												################## # LDAP # ##################
				
									           	1. Instalar LDAP
												2. Reconfigurar LDAP
												3. Instalar phpldapadmin
												4. Configurar acceso via web
				
												################################################
												"
												echo -n "Selecciona una opcion: "
													read serperfilfijo
													case $serperfilfijo in
														1) # LDAP - INSTALAR LDAP
														clear
															apt-get install slapd ldap-utils
														;; # LDAP - FIN INSTALAR LDAP
				
														2) # LDAP - RECONFIGURAR LDAP
														clear
															dpkg-reconfigure slapd
														;; # LDAP - FIN RECONFIGURAR LDAP
				
														3) # LDAP - INSTALAR PHPLDAPADMIN
														clear
															apt-get install phpldapadmin
														;; # LDAP - FIN INSTALAR PHPLDAPADMIN
				
														4)  # LDAP - CONFIGRAR ACCESO VIA WEB
														clear
															echo "Configurar el acceso vía web en fichero /usr/share/phpldapadmin/config/config.php"
																echo -n "DC [com]"
																	read dc0
																echo -n "DC [folgored]"
																	read dc1
																echo "\$servers->SetValue(‘server’,’base’,array(‘dc=$dc1,dc=$dc0’));" >>  /usr/share/phpldapadmin/config/config.php
				
																echo "\$servers->SetValue(‘login,’bind_id’,’cn=admin,dc=$dc1,dc=$dc0));" >>  /usr/share/phpldapadmin/config/config.php
														;; # LDAP - FIN CONFIGRAR ACCESO VIA WEB
													esac
							        	    ;; # FIN S_PERFILES FIJOS
							        	    
							        	    2) #S_PERFILES MOVILES
											clear
												echo "
												################## # LDAP SERVER MOVIL # ##################
					
												1. Instalar LDAP NFS
												2. Crear directorio
												3. Configurar PAM
					
												################################################
												"
													echo -n "Selecciona una opcion: "
														read serperfilmovil
															case $serperfilmovil in
																1) # LDAP - INSTALAR nfs server
																clear
																	apt-get install nfs-kernel-server
																;;
					
																2) # Crear directorio users
																clear
																	mkdir /home/users
																;;
					
																3) # LDAP - nfsserver
																clear
																	echo "/home/users * (rw,no_root_squash)     "   >> /etc/exports
																;;
															esac
											;; # FIN S_PERFILES MOVILES
							        	esac
							;;    
							
							2) # CLIENTES
							clear	
								echo "
									########## # CLIENTE LDAP # ###############
									
									1. Cliente Perfiles Fijos
									2. Cliente Perfiles Moviles
									
									###########################################
									"
									echo -n "Selecciona una opcion: "
										read clienteldapopc
											case $clienteldapopc in
								1) #C_PERFILES FIJOS
								clear
									echo "
									################## # LDAP CLIENTE FIJO # ##################
	
									1. Instalar LDAP Cliente
									2. Reconfigurar LDAP
									3. Configurar PAM
	
									################################################
									"
									echo -n "Selecciona una opcion: "
										read ldapopc
											case $ldapopc in
												1) # LDAP - INSTALAR LDAP
												clear
													apt-get install libnss-ldap
												;; # FIN LDAP - INSTALAR LDAP
	
												2) # LDAP - RECONFIGURAR LDAP
												clear
													dpkg-reconfigure ldap-auth-config
												;; # FIN LDAP - RECONFIGURAR LDAP
	
												3) # LDAP - CONFIGURAR PAM
												clear
													session required pam_mkhomedir.so skel=/etc/skel umask=0022 >> /etc/pam.d/common-session
												;; # FIN LDAP - CONFIGURAR PAM
											esac
								;; #FIN C_PERFILES FIJOS
								
								2) # C_PERFILES MOVILES
								
								
								;; #FIN C_PERFILES MOVILES
							esac
							;;
						esac
			;; # FIN LDAP

			7) # NFS
			clear
				echo "
				################## # NFS # ######################

				1. Servidor NFS
				2. Cliente NFS
				
				2. Instalar Clientes NFS
				3. Compartir Directorio
				4. Montar Directorio

				##################################################
				"
				echo -n "Selecciona una opcion: "
					read nfsopc
						case $nfsopc in
							1)
								apt-get install nfs-kernel-server
							;;
							
							2)
								apt-get install nfs-common
							;;
							
							3) 
								
							;;
							
							4)
							;;
						esac
			;; # FIN NFS

			8) # Samba
			clear
				echo "
				################# # Samba # #######################

				1. Instalar Servidor Samba
				2. Instalar Cliente Samba

				###################################################
				"
				echo -n "Selecciona una opcion: "
					read sambaopc
						case $sambaopc in
							1)
							;;
							2)
							;;
						esac
			;; # FIN Samba
			
			9) # SALIR
			clear
				salir="1"
			;; # FIN SALIR
        	10)
        	clear
        		echo "Script Creado por Jose Luis Romero	-	jlromero@protonmail.com"
        		read 
        	;;
			0) #ACTUALIZAR
			clear
				chmod 7777 actualizar.sh
				./actualizar.sh
			;;
		esac
done

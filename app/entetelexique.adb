package body entetelexique is

		function ChangementdeType(ligneEntree:chaine) return chaine is
		existe_changement:boolean:=true;
		ligne_convertie:chaine:=ligneEntree;
		begin
			while (existe_changement) loop
				if (contains(ligne_convertie,"entier")) then
					ligne_convertie:=replaceStr(ligne_convertie,"entier","integer");
				elsif (contains(ligne_convertie,"booleen")) then
					ligne_convertie:=replaceStr(ligne_convertie,"booleen","boolean");
				elsif (contains(ligne_convertie,"reel")) then
					ligne_convertie:=replaceStr(ligne_convertie,"reel","float");
				elsif (contains(ligne_convertie,"chaine")) then
					ligne_convertie:=replaceStr(ligne_convertie,"chaine","string");
				elsif (contains(ligne_convertie,"caractere")) then
					ligne_convertie:=replaceStr(ligne_convertie,"caractere","character");
				else
						existe_changement:=false;
				end if;
				end loop;
				return ligne_convertie;
		end ChangementdeType;


		procedure conversionEntete(ligneCourante:chaine; ligneConvertie: out chaine)is
		copieligneCourante:chaine:=ligneCourante;
		copieligneConvertie:chaine;
		copieligneConvertie_1:chaine;
		nom:chaine;
		variables:chaine;
		parametres:chaine;
		i,j,k:integer;
		existe_fleche:boolean:=true;
		type_retour:chaine;
		liste_variables:T_Tab_Chaine;
		liste_variables_converties:T_Tab_Chaine;
		ligne_courante:chaine;
		nom_param:chaine; --nom d'un paramètre
		reste:chaine; -- chaine 
		ligne_courante_convertie:chaine; --chaine représentant tous les paramètres converties en Ada
		begin
			if (startWith(ligneCourante,"module")) then
					i:=strpos(ligneCourante,'(');
					j:=strpos(ligneCourante,' ');
					nom:=substring(copieligneCourante,j+1,i-1);
					k:=strpos(ligneCourante,')');
					variables:=substring(copieligneCourante,i+1,k-1);
					copieligneConvertie:=CreateChaine("procedure ");
					copieligneConvertie:=(copieligneConvertie+nom)+'(';
					variables:=ChangementdeType(variables);
					liste_variables:=donneListeNom(variables);
					-- cette boucle permet à la fois de convertir les types, mais aussi de déplacer le "in" et le "out" après les deux points
						while (not estVide(liste_variables)) loop
							ligne_courante:=donne_tete(liste_variables);
							--remplace ↓ ↑ par in out
								if (contains(ligne_courante,"↓ ↑")) then
									ligne_courante:=replaceStr(ligne_courante,"↓ ↑","in out ");
									enleve_enTete(liste_variables);
									i:=strpos(ligne_courante,"in out");
									j:=strpos(ligne_courante,':');
									nom_param:=substring(ligne_courante,i+6,j-1);		
									reste:=substring(ligne_courante,j+1,length(ligne_courante));
									--permet de changer la postion du in out
									ligne_courante:=(((nom_param+':')+"in out ")+reste)+';';
									Ajout_queue(liste_variables_converties,ligne_courante);
									--remplace le ↑ par out
								elsif (contains(ligne_courante,"↑")) then
									ligne_courante:=replaceStr(ligne_courante,"↑","out ");
									enleve_enTete(liste_variables);
									i:=strpos(ligne_courante,"out ");
									j:=strpos(ligne_courante,':');
									nom_param:=substring(ligne_courante,i+3,j-1);		
									reste:=substring(ligne_courante,j+1,length(ligne_courante));
									--change la position du out
									ligne_courante:=(((nom_param+':')+"out ")+reste)+';';
									--remplace le ↓ par in
									Ajout_queue(liste_variables_converties,ligne_courante);
								elsif (contains(ligne_courante,"↓")) then
									ligne_courante:=replaceStr(ligne_courante,"↓","in ");
									enleve_enTete(liste_variables);
									i:=strpos(ligne_courante,"in ");
									j:=strpos(ligne_courante,':');
									nom_param:=substring(ligne_courante,i+2,j-1);		
									reste:=substring(ligne_courante,j+1,length(ligne_courante));
									--change la position du in
									ligne_courante:=(((nom_param+':')+"in ")+reste)+';';
									Ajout_queue(liste_variables_converties,ligne_courante);

								else
									enleve_enTete(liste_variables);
								end if;
							end loop;
					parametres:=createchaine(' ');
					-- cette boucle permet de convertir la liste qu'on a obtenu en une chaine
						While (not estVide(liste_variables_converties)) loop
							ligne_courante_convertie:=donne_tete(liste_variables_converties);
							parametres:=parametres+ligne_courante_convertie;
							enleve_enTete(liste_variables_converties);
						end loop;
					-- on ajout un à un les différents élements à copieligneConvertie;
					copieligneConvertie:=copieligneConvertie+parametres;
					copieligneConvertie:=copieligneConvertie+')';
					-- le i permet d'obtenir la postion de ")", afin de supprimer le dernier ;
					i:=strpos(copieligneConvertie,')');
					copieligneConvertie:=substring(copieligneConvertie,1,i-2);
					copieligneConvertie:=copieligneConvertie+')';
					
			elsif (startWith(ligneCourante,"fonction")) then
					i:=strpos(ligneCourante,'(');
					j:=strpos(ligneCourante,' ');
					nom:=substring(copieligneCourante,j+1,i-1);
					k:=strpos(ligneCourante,')');
					variables:=substring(copieligneCourante,i+1,k-1);
					copieligneConvertie:=CreateChaine("function ");
					copieligneConvertie:=(copieligneConvertie+nom)+'(';
					variables:=ChangementdeType(variables);
					liste_variables:=donneListeNom(variables);
					-- cette boucle permet à la fois de convertir les types, mais aussi de déplacer le "in" et le "out" après les deux points
						while (not estVide(liste_variables)) loop
							ligne_courante:=donne_tete(liste_variables);
							--remplace ↓ ↑ par in out
								if (contains(ligne_courante,"↓ ↑")) then
									ligne_courante:=replaceStr(ligne_courante,"↓ ↑","in out ");
									enleve_enTete(liste_variables);
									i:=strpos(ligne_courante,"in out");
									j:=strpos(ligne_courante,':');
									nom_param:=substring(ligne_courante,i+5,j-1);		
									reste:=substring(ligne_courante,j+1,length(ligne_courante));
									--change la position du in out
									ligne_courante:=(((nom_param+':')+"in out ")+reste)+';';
									Ajout_queue(liste_variables_converties,ligne_courante);
									--remplace le ↑ par out
								elsif (contains(ligne_courante,"↑")) then
									ligne_courante:=replaceStr(ligne_courante,"↑","out ");
									enleve_enTete(liste_variables);
									i:=strpos(ligne_courante,"out ");
									j:=strpos(ligne_courante,':');
									nom_param:=substring(ligne_courante,i+3,j-1);		
									reste:=substring(ligne_courante,j+1,length(ligne_courante));
									-- change la position du out
									ligne_courante:=(((nom_param+':')+"out ")+reste)+';';
									Ajout_queue(liste_variables_converties,ligne_courante);
									-- remplace les ↓ par in
								elsif (contains(ligne_courante,"↓")) then
									ligne_courante:=replaceStr(ligne_courante,"↓","in ");
									enleve_enTete(liste_variables);
									i:=strpos(ligne_courante,"in ");
									j:=strpos(ligne_courante,':');
									nom_param:=substring(ligne_courante,i+2,j-1);		
									reste:=substring(ligne_courante,j+1,length(ligne_courante));
									-- change la place du in
									ligne_courante:=(((nom_param+':')+"in ")+reste)+';';
									Ajout_queue(liste_variables_converties,ligne_courante);
								else
									enleve_enTete(liste_variables);
								end if;
							end loop;
					parametres:=createchaine(' ');
					-- cette boucle permet de convertir la liste qu'on a obtenu en une chaine
						While (not estVide(liste_variables_converties)) loop
							ligne_courante_convertie:=donne_tete(liste_variables_converties);
							parametres:=parametres+ligne_courante_convertie;
							enleve_enTete(liste_variables_converties);
						end loop;
					-- on ajout un à un les différents élements à copieligneConvertie;
					type_retour:=substring(copieligneCourante,k+2,length(copieligneCourante));
					type_retour:=ChangementdeType(type_retour);
					copieligneConvertie:=copieligneConvertie+parametres;
					copieligneConvertie:=copieligneConvertie+')';
					-- le i permet d'obtenir la postion de ")", afin de supprimer le dernier ;
					i:=strpos(copieligneConvertie,')');
					copieligneConvertie_1:=substring(copieligneConvertie,1,i-2);
					-- on rajoute le return à la fin:
					copieligneConvertie:=(copieligneConvertie_1+")return ")+type_retour;
			end if;
				ligneConvertie:=copieligneConvertie;
		end conversionEntete;
	
	
	
	
	

		procedure affiche(elt: ligne)is		
		begin
				put_line("type de variable: "&T_typeline'image(elt.Forme));
				put("nom: ");
				Put_line(elt.nom);
				put("commentaire: ");
				Put_line(elt.commentaire);
				if (elt.Forme=fonction) then
					Put("Type de la fonction: ");
					Put_line(elt.leType);
				elsif (elt.Forme=variable) then
					Put("Type de la variable: ");
					Put_line(elt.leType);
				elsif (elt.Forme=constante) then
					Put("valeur de la constante: ");
					Put_line(elt.valeur);
				elsif (elt.Forme=structure) then
					Put("ensemble des élements de la structure: ");
					Put_line(elt.ensElement);
				elsif (elt.Forme=table) then
					Put("intervalle de la table: ");
					Put_line(elt.intervalle);
					Put("Type des élements de la table: ");
					Put_line(elt.typeElement);
				end if; 
				New_Line;				
		end affiche;
		
		
		
		
		
		procedure analyseLexique(listeLexique: T_Tab_ligne; resLexique: in out T_tab_Lexique) is
			liste_ligne:T_Tab_ligne:=listeLexique;
			ligne_courant: chaine:=donne_tete(listeLexique); --ligne courante à étudier
			Forme_ligne:T_typeline:=donneTypeLigne(ligne_courant); --type de la ligne courante (fonction,variable,table...)
			courant:ligne; --ligne courante après l'analyse qui sera stockée dans resLexique
			
				begin
					While (not estVide(liste_ligne)) loop
						ligne_courant:=donne_tete(liste_ligne);
						Forme_ligne:=donneTypeLigne(ligne_courant);
						--création de l'élement en fonction du type
						if (Forme_ligne=fonction) then
							courant:=donnerFonction(donneNom(ligne_courant),donneCommentaire(ligne_courant),donneType(ligne_courant));
						elsif (Forme_ligne=variable) then
							courant:=donnerVariable(donneNom(ligne_courant),donneCommentaire(ligne_courant),donneTypeVariable(ligne_courant));
						elsif (Forme_ligne=constante) then
							courant:=donnerConstante(donneNom(ligne_courant),donneCommentaire(ligne_courant),donneType(ligne_courant),donneValeurConstante(ligne_courant));
						elsif (Forme_ligne=structure) then
							courant:=donnerStructure(donneNom(ligne_courant),donneCommentaire(ligne_courant),donneEltStructure(ligne_courant));
						elsif (Forme_ligne=table) then
							courant:=donnerTable(donneNom(ligne_courant),donneCommentaire(ligne_courant),donneEnsDefinition(ligne_courant),donneTypeEltDeTable(ligne_courant));
						elsif (Forme_ligne=module) then
							courant:=donnerModule(donneNom(ligne_courant),donneCommentaire(ligne_courant));
						end if;
						Ajout_queue(resLexique,courant);
						enleve_enTete(liste_ligne);
						New_Line;
					end loop;
		end analyseLexique;

		
		
		
		
		procedure conversionLexique(Lexique: T_tab_Lexique; resultat: in out T_tab_ligne) is
		liste_lexique:T_tab_Lexique:=Lexique;
		ligne_courante:ligne:=donne_tete(Lexique);
		ligne_convertie:chaine;
		retour_ligne:string(1..1);
		liste_ligne_convertie:T_tab_ligne;
				
		begin
			retour_ligne(1):=ASCII.LF;

			While (not estVide(liste_lexique)) loop
				ligne_courante:=donne_tete(liste_lexique);
				--traduction en Ada en fonction du type de la ligne (fonction,variable,table...)
				if (ligne_courante.Forme=Variable) then
					ligne_convertie:=ligne_courante.nom+':';
					ligne_convertie:=ligne_convertie+ChangementdeType(ligne_courante.leType)+';';
					
				elsif (ligne_courante.Forme=constante) then
					ligne_convertie:=ligne_courante.nom+":constant ";
					ligne_convertie:=(ligne_convertie+ChangementdeType(ligne_courante.leType))+":=";
					ligne_convertie:=ligne_convertie+(ligne_courante.valeur+';');

				elsif (ligne_courante.Forme=table) then
					ligne_convertie:=("type "+ligne_courante.nom);
					ligne_convertie:=ligne_convertie+(" is array("+ligne_courante.intervalle);
					ligne_convertie:=((ligne_convertie+") of ")+ChangementdeType(ligne_courante.typeElement)+';');

				elsif (ligne_courante.Forme=structure) then
					ligne_convertie:=("type "+ligne_courante.nom);
					ligne_convertie:=ligne_convertie+" is record  ";
					ligne_convertie:=ligne_convertie+retour_ligne;
					ligne_convertie:=ligne_convertie+ChangementdeType(ligne_courante.ensElement);
					ligne_convertie:=ligne_convertie+';';
					ligne_convertie:=ligne_convertie+(retour_ligne+"end record;");

				end if;
				
				if (length(ligne_courante.commentaire)>1) then
					ligne_convertie:=ligne_convertie+(" --"+ligne_courante.commentaire);
				end if;
 				Ajout_queue(resultat,ligne_convertie);
 				enleve_enTete(liste_lexique);
 			end loop;
				
		end conversionLexique;
					


					
					
		function donneListeNom(ligneCourante: chaine) return T_Tab_Chaine is
			liste: T_Tab_Chaine;
			ligne:chaine:=ligneCourante+";";
			i: integer;
			existe_apres:boolean:=true;
			
			begin
				liste:=Creer_liste;	
				while (existe_apres) loop
				i := strpos(ligne, ';');
				if (i=length(ligne)) then
				existe_apres:=false;
				Ajout_queue(liste,substring(ligne,1,i-1));
				else
				existe_apres:=true;
				Ajout_queue(liste,substring(ligne,1,i-1));
				ligne := substring(ligne, i+1, length(ligne));
				end if;
				end loop;
				return liste;
		end donneListeNom;
		
		
		
		
		
		procedure variableExiste(listedesvariables:T_tab_Lexique; variable:chaine; existe:out boolean; type_variable: out chaine)is
		se_trouve:boolean:=false;
		liste_ligne:T_Tab_Lexique:=listedesvariables;
		element_a_analyser:ligne; --ligne courante de la liste des variables
		pas_trouve:chaine:=createchaine("variable non trouve");
		begin
			element_a_analyser:=donne_tete(liste_ligne);
			While ((not se_trouve) and (not estVide(liste_ligne))) loop
				element_a_analyser:=donne_tete(liste_ligne);
				if (element_a_analyser.nom=variable) then
					existe:=true;
					se_trouve:=true;
					type_variable:=element_a_analyser.leType;
				else
					existe:=false;
					enleve_enTete(liste_ligne);
					type_variable:=pas_trouve;
				end if;
			end loop;
		end variableExiste;
		
		
		
		
		
	function donneNom(ligneCourante: chaine) return chaine is
		ligne:chaine:=ligneCourante;
		i:integer;
		begin
			i:=strpos(ligne, '(');
			ligne:=substring(ligne,1,i-1);
			return ligne;
	end donneNom;
		
		
		
		
		
	function donneTypeLigne(ligneCourante: chaine) return T_typeline is
		typeLigne: T_typeline;
		i,j:integer;
		ligne:chaine:=ligneCourante;
		begin
			i:=strpos(ligne, '(');
			ligne:=substring(ligne,i+1,length(ligne)); --réduit tout la partie de la ligne située avant la parenthèse
			-- regarde le premier mot de la ligne et en fonction de ce mot, dis le type de la ligne
			if (startWith(ligne, "cste")) then
				typeLigne:=constante;
			elsif (startWith(ligne, "fonction")) then
				typeLigne:=fonction;
			elsif (startWith(ligne, "module")) then
				typeLigne:=module;
			elsif (startWith(ligne, "type")) then
				j:=strpos(ligne, '=');
				ligne:=substring(ligne,j+1,length(ligne));
				if (startWith(ligne, "table")) then
					typeLigne:=table;
				elsif (startWith(ligne, "structure")) then
					typeLigne:=structure;
				end if;
			else
				typeLigne:=variable;
			end if;
			return typeLigne;
	end donneTypeLigne;

	
	
	
	
	function donneCommentaire(ligneCourante: chaine) return chaine is
		i:integer;
		ligne:chaine:=ligneCourante;
		type_ligne:T_typeline;
		pas_de_com:string:=" ";
		begin
			type_ligne:=donneTypeLigne(ligne);
			--donne le commentaire en fonction du type de la ligne
			if (type_ligne=structure) then
				i:=strpos(ligne, '=');
				ligne:=substring(ligne,i+1,length(ligne));
				i:=strpos(ligne, ')');
				ligne:=substring(ligne,i,length(ligne));
				i:=strpos(ligne, ':');
				if (i/=0) then
					ligne:=substring(ligne,i+1,length(ligne));
				else 
					ligne:=createchaine(pas_de_com);
				end if;
			else
				i:=strpos(ligne, ':');
				if (i/=0) then
					ligne:=substring(ligne,i+1,length(ligne));
				else
					ligne:=createchaine(pas_de_com);
				end if;
			end if;
			return ligne;
	end donneCommentaire;
			
			
			
			
			
	function donneType(ligneCourante: chaine) return chaine is
		c: chaine;
		ligne:chaine:=ligneCourante;
		i:integer; 
		j:integer; 
		k:integer; 
		begin
 			i:=strpos(ligne, '(');
 			ligne:=substring(ligne, i+1, length(ligne));
			if (startWith(ligne, "fonction")) then --donne le type de retour de la fonction
 				k:=strpos(ligne, '/');
 				j:=strpos(ligne, ')');
				c:=substring(ligne,k+1,j-1);
			elsif (startWith(ligne, "cste")) then -- donne le type de la constante
				k:=strpos(ligne, '/');
				j:=strpos(ligne, '=');
				c:=substring(ligne,k+1,j-1);
			end if;
			return c;
	end donneType;
			
			
			
			
			
	function donneTypeEltDeTable(ligneCourante: chaine) return chaine is
		c: chaine;
		i,j:integer;
		ligne:chaine:=ligneCourante;
		begin
			i:=strpos(ligne, ']');
			j:=strpos(ligne, ':');
			if (j=0) then
				c:=substring(ligne,i+1,length(ligne));
			else
				c:=substring(ligne,i+1,j-1);
			end if;
			return c;
	end donneTypeEltDeTable;
	
	
	
	
	
	function donneEnsDefinition(ligneCourante: chaine) return chaine is
		c: chaine;
		i,j:integer;
		ligne:chaine:=ligneCourante;
		begin
			i:=strpos(ligne, '[');
			j:=strpos(ligne, ']');
			c:=substring(ligne,i+1,j-1);
			return c;
	end donneEnsDefinition;
	
	
	
	
	
	function donneEltStructure(ligneCourante: chaine) return chaine is
		c:chaine;
		i,j:integer;
		ligne:chaine:=ligneCourante;
		begin
			i:=strpos(ligne, '=');
			ligne:=substring(ligne, i+1, length(ligne));
			i:=strpos(ligne, '(');
			j:=strpos(ligne, ')');
			c:=substring(ligne, i+1,j-1);
						return c;
	end donneEltStructure;
	
	
	
	
	
	function donneTypeVariable(ligneCourante: chaine) return chaine is
		c: chaine;
		i,j:integer;
		ligne:chaine:=ligneCourante;
		begin
			i:=strpos(ligne, '(');
			j:=strpos(ligne, ')');
			c:=substring(ligne, i+1,j-1);
			return c;
	end donneTypeVariable;
	
	
	
	
	
	function donneValeurConstante(ligneCourante: chaine) return chaine is
		c: chaine;
		i,j:integer;
		ligne:chaine:=ligneCourante;
		begin
			i:=strpos(ligne, '=');
			j:=strpos(ligne, ')');
			c:=substring(ligne,i+1,j-1);
			return c;
	end donneValeurConstante;

	
	
	
	
	function donnerFonction(nom, commentaire, typeRetour: chaine) return ligne is
		l: ligne(fonction);
		
		begin
			l.nom:=nom;
			l.commentaire:=commentaire;
			l.leType:=typeRetour;
			return l;
	end donnerFonction;

	
	
	
	
	function donnerModule(nom, commentaire: chaine) return ligne is
		l: ligne(module);
		
		begin
			l.nom:=nom;
			l.commentaire:=commentaire;
			return l;
	end donnerModule;
	
	
	
	
	
	function donnerVariable(nom, commentaire, typeValeur: chaine) return ligne is
		l: ligne(variable);
		
		begin
			l.nom:=nom;
			l.commentaire:=commentaire;
			l.leType:=typeValeur;
			return l;
	end donnerVariable;
	
	
	
	
	
	function donnerConstante(nom, commentaire, typeValeur, valeur: chaine) return ligne is
		l: ligne(constante);
		
		begin
			l.nom:=nom;
			l.commentaire:=commentaire;
			l.leType:=typeValeur;
			l.valeur:=valeur;
			return l;
	end donnerConstante;
	
	
	
	
	
	function donnerTable(nom, commentaire, intervalle, typeElement: chaine) return ligne is
		l: ligne(table);
		
		begin
			l.nom:=nom;
			l.commentaire:=commentaire;
			l.intervalle:=intervalle;
			l.typeElement:=typeElement;
			return l;
	end donnerTable;
	
	
	
	
	
	function donnerStructure(nom, commentaire, ensElement: chaine) return ligne is
		l: ligne(structure);
		
		begin
			l.nom:=nom;
			l.commentaire:=commentaire;
			l.ensElement:=ensElement;		
			return l;
	end donnerStructure;
	
	
	
	
	
end entetelexique;

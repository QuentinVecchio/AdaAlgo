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
					ligne_convertie:=replaceStr(ligne_convertie,"caractere","char");
				else
						existe_changement:=false;
				end if;
				end loop;
				return ligne_convertie;
		end ChangementdeType;


		procedure conversionEntete(ligneCourante:chaine; ligneConvertie: out chaine)is
		copieligneCourante:chaine:=ligneCourante;
		copieligneConvertie:chaine;
		nom:chaine;
		variables:chaine;
		i,j,k:integer;
		fleche_haut:string:="↑";
		fleche_bas:string:="↓";
		existe_fleche:boolean:=true;
		type_retour:chaine;
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
				while (existe_fleche) loop
					if (contains(copieligneCourante,fleche_haut)) then
						variables:=replaceStr(variables,fleche_haut,"out ");
					elsif (contains(copieligneCourante,fleche_bas)) then
						variables:=replaceStr(variables,fleche_bas,"in ");
					else
						existe_fleche:=false;
					end if;
				end loop;
				copieligneConvertie:=copieligneConvertie+variables;
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
				while (existe_fleche) loop
					if (contains(copieligneCourante,fleche_haut)) then
						variables:=replaceStr(variables,fleche_haut,"out ");
					elsif (contains(copieligneCourante,fleche_bas)) then
						variables:=replaceStr(variables,fleche_bas,"in ");
					else
						existe_fleche:=false;
					end if;
				end loop;
				type_retour:=substring(copieligneCourante,k+1,length(copieligneCourante));
				copieligneConvertie:=copieligneConvertie+variables;
				copieligneConvertie:=copieligneConvertie+')';
				copieligneConvertie:=copieligneConvertie+type_retour;
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
		
		
		
		
		
		procedure analyseLexique(listeLexique: T_Tab_ligne; resLexique: out T_tab_Lexique) is
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

		
		
		
		
		procedure conversionLexique(Lexique: T_tab_Lexique; resultat: out T_tab_ligne) is
		resultat_conv:T_tab_ligne;
		liste_lexique:T_tab_Lexique:=Lexique;
		ligne_courante:ligne:=donne_tete(Lexique);
		ligne_convertie:chaine;
		retour_ligne:string(1..1);
		liste_ligne_convertie:T_tab_ligne;
				
		begin
			retour_ligne(1):=ASCII.LF;
 			resultat_conv:=Creer_liste;
			While (not estVide(liste_lexique)) loop
				ligne_courante:=donne_tete(liste_lexique);
				--traduction en Ada en fonction du type de la ligne (fonction,variable,table...)
				if (ligne_courante.Forme=Variable) then
					ligne_convertie:=ligne_courante.nom+':';
					ligne_convertie:=ligne_convertie+ChangementdeType(ligne_courante.leType);
					
				elsif (ligne_courante.Forme=constante) then
					ligne_convertie:=ligne_courante.nom+":constant ";
					ligne_convertie:=(ligne_convertie+ChangementdeType(ligne_courante.leType))+":=";
					ligne_convertie:=ligne_convertie+(ligne_courante.valeur+';');

				elsif (ligne_courante.Forme=table) then
					ligne_convertie:=("type "+ligne_courante.nom);
					ligne_convertie:=ligne_convertie+(" is array("+ligne_courante.intervalle);
					ligne_convertie:=((ligne_convertie+") of ")+ChangementdeType(ligne_courante.typeElement));

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
 				Ajout_queue(liste_ligne_convertie,ligne_convertie);
 				enleve_enTete(liste_lexique);
 			end loop;
 			resultat:=liste_ligne_convertie;
				
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

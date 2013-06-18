package body entetelexique is

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
			ligne_courant: chaine:=donne_tete(listeLexique);
			Forme_ligne:T_typeline:=donneTypeLigne(ligne_courant);
			courant:ligne;
			liste_nom:T_Tab_Chaine;
			resultat:T_tab_Lexique;			
				begin
					While (not estVide(liste_ligne)) loop
						ligne_courant:=donne_tete(liste_ligne);
						Forme_ligne:=donneTypeLigne(ligne_courant);
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

		
		
		
		procedure pas_idee_nom(Lexique: T_tab_Lexique; resultat: out T_tab_ligne) is
		resultat_conv:T_tab_ligne;
		ligne_courante:chaine;
		begin
			null;
-- 			resultat_conv:=Creer_liste;
-- 			--While (not estVide(liste_lexique)) loop
-- 				if (Lexique.Forme=Variable) then
-- 					ligne_courante:=liste_lexique.nom+'('+ligne_courante.leType+')'+liste_lexique.commentaire;
-- 				end if;
-- 				resultat:=ligne_courante;
				
		end pas_idee_nom;
					
					
			


		function donneListeNom(ligneCourante: chaine) return T_Tab_Chaine is
			liste: T_Tab_Chaine;
			ligne:chaine:=ligneCourante+",";
			i: integer;
			existe_apres:boolean:=true;
			
			begin
				liste:=Creer_liste;	
				while (existe_apres) loop
				i := strpos(ligne, ',');
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
			ligne:=substring(ligne,i+1,length(ligne));
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
		pas_de_com:string:="/";
		begin
			type_ligne:=donneTypeLigne(ligne);
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
			if (startWith(ligne, "fonction")) then
 				k:=strpos(ligne, '/');
 				j:=strpos(ligne, ')');
				c:=substring(ligne,k+1,j-1);
			elsif (startWith(ligne, "cste")) then
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

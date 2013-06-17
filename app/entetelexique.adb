package body entetelexique is

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


	function donneTypeLigne(ligneCourante: chaine) return T_typeline is
		typeLigne: T_typeline;
		i,j:integer;
		ligne:chaine:=ligneCourante;
		begin
			i:=strpos(ligne, '(');
			j:=strpos(ligne, '=');
			ligne:=substring(ligne,i+1,length(ligne));
			if (startWith(ligne, "cste")) then
				typeLigne:=constante;
			elsif (startWith(ligne, "fonction")) then
				typeLigne:=fonction;
			elsif (startWith(ligne, "module")) then
				typeLigne:=module;
			elsif (startWith(ligne, "type")) then
				typeLigne:=structure;
			elsif (j /=0) then
				typeLigne:=table;
			else
				typeLigne:=variable;
			end if;
			return typeLigne;
	end donneTypeLigne;

	function donneCommentaire(ligneCourante: chaine) return chaine is
		c: chaine;
		i:integer;
		ligne:chaine:=ligneCourante;
		begin
			i:=strpos(ligne, ':');
			c:=substring(ligne,i+1,length(ligne));
			return c;
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
			l.nom:=nom,
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
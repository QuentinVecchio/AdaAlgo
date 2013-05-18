package body entetelexique is

		function donneListeNom(ligneCourant: chaine) return T_Tab_Chaine is
			liste: T_Tab_Chaine;
			begin
				return liste;
		end donneListeNom;


	function donneTypeLigne(ligneCourant: chaine) return T_typeline is
		typeLigne: T_typeline;
		begin
			return typeLigne;
	end donneTypeLigne;

	function donneCommentaire(ligneCourant: chaine) return chaine is
		c: chaine;
		begin
			return c;
	end donneCommentaire;
			
	function donneType(ligneCourant: chaine) return chaine is
		c: chaine;
		begin
			return c;
	end donneType;
			
	function donneTypeEltDeTable(ligneCourant: chaine) return chaine is
		c: chaine;
		begin
			return c;
	end donneTypeEltDeTable;
	
	function donneEnsDefinition(ligneCourant: chaine) return chaine is
		c: chaine;
		begin
			return c;
	end donneEnsDefinition;
	
	function donneEltStructure(ligneCourant: chaine) return chaine is
		c: chaine;
		begin
			return c;
	end donneEltStructure;
	
	
	
	function donneTypeVariable(ligneCourant: chaine) return chaine is
		c: chaine;
		begin
			return c;
	end donneTypeVariable;
	
	function donneValeurConstante(ligneCourant: chaine) return chaine is
		c: chaine;
		begin
			return c;
	end donneValeurConstante;

	function donnerFonction(nom, commentaire, typeRetour: chaine) return ligne is
		l: ligne(fonction);
		
		begin
		
			return l;
	end donnerFonction;

	function donnerModule(nom, commentaire: chaine) return ligne is
		l: ligne(module);
		
		begin
		
			return l;
	end donnerModule;
	
	function donnerVariable(nom, commentaire, typeValeur: chaine) return ligne is
		l: ligne(variable);
		
		begin
		
			return l;
	end donnerVariable;
	
	
	function donnerConstante(nom, commentaire, typeValeur, valeur: chaine) return ligne is
		l: ligne(constante);
		
		begin
		
			return l;
	end donnerConstante;
	
	function donnerTable(nom, commentaire, intervalle, typeElement: chaine) return ligne is
		l: ligne(table);
		
		begin
		
			return l;
	end donnerTable;
	
	function donnerStructure(nom, commentaire, ensElement: chaine) return ligne is
		l: ligne(structure);
		
		begin
		
			return l;
	end donnerStructure;
	
end entetelexique;
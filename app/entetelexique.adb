package body entetelexique is

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
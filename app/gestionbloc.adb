with simple_io; use simple_io;
package body gestionbloc is


	procedure creerListe(L: out T_Tab_Bloc) is
		begin
			if(NOT estFinListe(L) and NOT estVide(L))then
				raise liste_deja_cree;
			end if;
			L.courant := null;
			L.suivant := null;
		
	end creerListe;

	function estVide(L: T_Tab_Bloc)return boolean is
		begin
			return (L.courant = null);
	end estVide;
	
	function estFinListe(L: T_Tab_Bloc) return boolean is
		begin
			return (L.suivant = null);
	end estFinListe;
	
	procedure ajoutElt(L: in out T_Tab_Bloc; elt: Bloc)is
		begin
		
		if(NOT estVide(L))then
			ajoutElt(L.suivant.all, elt);
		else
			L.courant := new Bloc'(elt);
			declare
				newL: T_Tab_Bloc;
				begin
				creerListe(newL);
				L.suivant:= new T_Tab_Bloc'(newL);
			end;
		end if;
	end ajoutElt;

	procedure afficheTypeElt(L: in T_Tab_Bloc)is
		begin
			if(NOT estVide(L)) then
				put_line(L.courant.all.forme);
				if(NOT estFinListe(L))then
					afficheTypeElt(L.suivant.all);
				end if;
			end if;
		
	end afficheTypeElt;
	
	
	procedure donneTete(L: T_Tab_Bloc; elt: in out Bloc)is
		begin
			if(NOT estVide(L))then
				elt := L.courant.all;
			else
				raise liste_non_cree;
			end if;
	end donneTete;
	
	procedure enleveTete(L: in out T_Tab_Bloc)is
		begin
			if(NOT estFinListe(L) or estVide(L))then
				L.suivant := null;
				L.courant := null;
			else
				L.courant := new Bloc'(L.suivant.all.courant.all);
				L.suivant.all := L.suivant.all.suivant.all;
			end if;
	end enleveTete;
	
	procedure ajoutCommentaire(L: in out T_Tab_Bloc; com: chaine)is
		b:Bloc(commentaire);
		
		begin
			b.MonCom := com;
			ajoutElt(L, b);

	end ajoutCommentaire;
	
	procedure ajoutModule(L: in out T_Tab_Bloc; modaAjouter: chaine)is
		b: Bloc(module);
		
		begin
			b.MonMod := modaAjouter;
			ajoutElt(L, b);
	end ajoutModule;
	
	procedure ajoutAffectation(L: in out T_Tab_Bloc;  partieGauche, partieDroite : chaine)is
		b: Bloc(affectation);
	
		begin
			b.vG := partieGauche;
			b.vD := partieDroite;
			ajoutElt(L, b);
			
	end ajoutAffectation;
	
	procedure ajoutBlocCond(L: in out T_Tab_Bloc; tabBloc: T_Tab_Bloc) is
		b: Bloc(blocCond);
		begin
			b.MTab := tabBloc;
			ajoutElt(L, b);
	end ajoutBlocCond;
	
	procedure ajoutPour (L: in out T_Tab_Bloc; cond: chaine; Liste_Int : T_Tab_Bloc) is
			b: Bloc(pour);
			begin
					b.CondContinu := cond;
					b.Tab_bloc:= Liste_Int;
					ajoutElt(L, b);
	end ajoutPour;

	procedure ajoutTq (L: in out T_Tab_Bloc; cond: chaine; Liste_Int : T_Tab_Bloc) is
			b: Bloc(pour);
			begin
					b.CondContinu := cond;
					b.Tab_Bloc:= Liste_Int;
					ajoutElt(L, b);

	end ajoutTq;

	procedure ajoutRepeter (L: in out T_Tab_Bloc; cond: chaine; Liste_Int : T_Tab_Bloc) is
			b: Bloc(pour);
			begin
					b.CondContinu := cond;
					b.Tab_Bloc:= Liste_Int;
					ajoutElt(L, b);

	end ajoutRepeter;

	procedure Ajout_Si(L: in out T_Tab_Bloc; cond: chaine; Liste_Int : T_Tab_Bloc) is
		b: bloc(si);	
	begin
		b.Liste := Liste_Int;
		b.Cond := cond;
		ajoutElt(L,b);
		
	end Ajout_Si;

	procedure Ajout_SinonSi(L: in out T_Tab_Bloc; cond: chaine; Liste_Int : T_Tab_Bloc) is
		b: bloc(SinonSi);
	begin
		b.Liste := Liste_int;
		b.cond := cond;
		ajoutElt(L,b);
		
	end Ajout_SinonSi;

	procedure Ajout_Sinon(L: in out T_Tab_Bloc; Liste_Int : T_Tab_Bloc) is
		b: bloc(Sinon);
	begin
		b.Liste := Liste_int;
		ajoutElt(L,b);
	end Ajout_Sinon;

	procedure ajoutBlocCas(L: in out T_Tab_Bloc; ListeInterne: T_Tab_Bloc; var: chaine) is 
		b: bloc(blocCase);
	begin
		b.variableATester := var;
		b.Liste_case := ListeInterne;
		
	end ajoutBlocCas;

        procedure AjoutCas(L: in out T_Tab_Bloc; ListeInterne: T_Tab_Bloc; condition: chaine) is
		b: bloc(BlocIntCase);
	begin
		b.instructCase := ListeInterne;
		b.condCase := condition;
		ajout(L, b);
	end AjoutCas;



	
	function "="(L1, L2 : T_Tab_Bloc) return boolean is
		begin
		
			if(NOT estVide(L1) and then NOT estVide(L2))then
				if(L1.courant.forme /= L2.courant.forme)then
					return false;
				end if;
				if(NOT estFinListe(L1))then
					return L1.suivant.all = L2.suivant.all;
				end if;
			else
				return estVide(L1) or else estVide(L2);
			end if;
			
			return false;
	end "=";
	
end gestionbloc;

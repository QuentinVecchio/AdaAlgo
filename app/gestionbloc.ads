with definitions, mstring, typeEnum;
use definitions, mstring;

package gestionbloc is

	-- Permet d'affiche le type d'élément pour la fonction afficheElt
	package AfficheT_elt is new typeEnum(T_elmt);
	use AfficheT_elt;
	
	
	-- type contenant la liste des blocs 
	type T_Tab_Bloc is private;

	-- pointeur pour définition récursive
	type T_ACCESS_Tab_Bloc is ACCESS T_Tab_Bloc;
	
	-- type bloc regroupant tout les types que l'on peut rencontrer dans un algo
	-- C'est a dire que c'est une représentation des différents éléments que l'on rencontre dans une chaine
	--      Le commentaire et le module sont composés d'un seul champs représentant la ligne
	--      L'affection comporte deux champs représentant la variable de gauche et celle de droite
	--      Pour, tq et repeter sont constitués d'une condition et d'un tableau de bloc, tableau représentant
	--      l'ensemble des instructions au sein de la boucle
	--
	--      Le blocCond contient un tableau de bloc, ces blocs sont de type si, sinon si, ou sinon
	--      les bloc si, sinon si et sinon comporte un ensemble d'instructions (tableau de bloc)
	--      pour si, sinon si on un champ condition en plus

	type Bloc(Forme: T_elmt) is record
			case Forme is
					when commentaire        => MonCom : chaine;
					when module             => MonMod: chaine;
					when affectation        => vG, vD : chaine;
					when pour | tq | repeter=> CondContinu : chaine;
												Tab_Bloc : T_Tab_Bloc;
					when blocCond           => MTab : T_Tab_Bloc;
					when blocCase           => variableATester: chaine;
												Liste_case : T_Tab_Bloc;
												case Forme is
														when defaut => null;
														when others => CondCase: chaine;
												end case;
					-- les si, sinon si, sinon
					when others             => Liste: T_Tab_Bloc;
												case Forme is
														when sinon => null;
														when others => cond: chaine;
												end case;
			end case;

	end record;


	liste_deja_cree: exception;
	
	liste_non_cree: exception;
	
	--
	--      Crée une nouvelle liste
	--      peut lancer liste_deja_cree 
	--      @param L, la liste vide crée
	--
	procedure creerListe(L: out T_Tab_Bloc);

	--
	--      Définit si une liste est vide
	--      @param L, la liste a tester
	--      @return vrai, si la liste est vide
	--      @return faux, si la liste contient des éléments
	--
	function estVide(L: T_Tab_Bloc)return boolean;

	--
	--      Définit si l'élément et le dernier de la liste
	--      @param L, la liste a tester
	--      @return vrai, si c'est la fin de liste
	--      @return false, sinon
	--
	function estFinListe(L: T_Tab_Bloc) return boolean;

	--
	--      Permet l'ajout d'un élément quelconque en fin de liste
	--      @param L, la liste dans laquelle on ajoute un élément
	--      @param elt, l'élément a ajouter dans la liste
	--
	procedure ajoutElt(L: in out T_Tab_Bloc; elt: Bloc);

	--
	--      Permet d'afficher la liste (uniquement le type des éléments)
	--      L'ordre d'affichage est du dernier ajouté au premier ajouté
	--      @param L, la liste a afficher
	--
	procedure afficheTypeElt(L: in T_Tab_Bloc);

	
	--
	--      Donne le premier élément de la liste, sans l'enlever
	--      @param L, la liste où se trouver l'élément a donner
	--      @return elt, le premier élément de la liste renvoyé
	--
	procedure donneTete(L: T_Tab_Bloc; elt: in out Bloc);

	--
	--      Enleve le premier élément de la liste
	--      @param L, la liste a manipuler
	--
	procedure enleveTete(L: in out T_Tab_Bloc);

	--
	--      Ajout un bloc commentaire en fin de liste
	--      @param L, la liste a manipuler
	--      @param com, le commentaire a ajouter
	--
	procedure ajoutCommentaire(L: in out T_Tab_Bloc; com: chaine);

	--
	--      Ajout un bloc module en fin de liste
	--      @param L, la liste a manipuler
	--      @param com, le module a ajouter
	--
	procedure ajoutModule(L: in out T_Tab_Bloc; modaAjouter: chaine);

	--
	--      Ajout un bloc affectation en fin de liste
	--      @param L, la liste a manipuler
	--      @param com, l'affectation a ajouter
	--
	procedure ajoutAffectation(L: in out T_Tab_Bloc;  partieGauche, partieDroite : chaine);


	--
	--      Ajout un bloc blocCond en fin de liste
	--      @param L, la liste a manipuler
	--      @param com, le blocCond a ajouter
	--
	procedure ajoutBlocCond(L: in out T_Tab_Bloc; tabBloc: T_Tab_Bloc);

	--
	--      Ajout un bloc pour en fin de liste
	--      @param L, la liste ou sera ajouté l'élément
	--      @param cond, la condition de la boucle
	--      @param Loste_Int, l'ensemble des opérations effectuée au sein de la boucle
	--
	procedure ajoutPour (L: in out T_Tab_Bloc; cond: chaine; Liste_Int : T_Tab_Bloc);

	--
	--      Ajout un bloc tq en fin de liste
	--      @param L, la liste ou sera ajouté l'élément
	--      @param cond, la condition de la boucle
	--      @param Loste_Int, l'ensemble des opérations effectuée au sein de la boucle
	--      
	procedure ajoutTq (L: in out T_Tab_Bloc; cond: chaine; Liste_Int : T_Tab_Bloc);

	--
	--      Ajout un bloc repeter en fin de liste
	--      @param L, la liste ou sera ajouté l'élément
	--      @param cond, la condition de la boucle
	--      @param Loste_Int, l'ensemble des opérations effectuée au sein de la boucle
	--      
	procedure ajoutRepeter (L: in out T_Tab_Bloc; cond: chaine; Liste_Int : T_Tab_Bloc);

	--
	--	Ajout le bloc si au bloc conditionnel
	--	@param L, la liste ou sera ajouté l'élement
	--	@param cond, la condition de la boucle
	--
	procedure Ajout_Si(L: in out T_Tab_Bloc; cond: chaine; Liste_Int : T_Tab_Bloc);

	--
	--	Ajout le bloc 'sinon si' au bloc conditionnel
	--	@param L, la liste ou sera ajouté l'élement
	--	@param cond, la condition de la boucle
	--
	procedure Ajout_SinonSi(L: in out T_Tab_Bloc; cond: chaine; Liste_Int : T_Tab_Bloc);

	--
	--	Ajout le bloc 'sinon' au bloc conditionnel
	--	@param L, la liste ou sera ajouté l'élement
	--	@param cond, la condition de la boucle
	--
	procedure Ajout_Sinon(L: in out T_Tab_Bloc; Liste_Int : T_Tab_Bloc);
	

	--
	--      Test l'égalité entre deux T_Tab_Bloc (compare uniquement le type des éléments)
	--      @param L1,L2 sont les listes de bloc a comparer
	--
	function "="(L1, L2 : T_Tab_Bloc) return boolean;

	
	private
	
		--
		-- Modélise l'élément d'une chaine
		--
		type T_Tab_Bloc is record
			
			courant: ACCESS Bloc;
			suivant: T_ACCESS_Tab_Bloc;
			
		end record;	
end gestionbloc;

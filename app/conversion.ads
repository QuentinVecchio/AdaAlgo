-----------------------------------------------------------------------------------------
--
--	Paquetage Conversion:
--
--		Paquetage regroupant les fonctions et procédures nécessaire pour convertir un algo
--		(Représentation en mémoire) en langage Ada. Ce paquetage suppose que la syntaxe est correcte
--		La procédure principale conversionAda permet de convertir tout un algorithme
--		Toutes les autres procédures permettent de convertir un élément précis
--		
--
--		@author Nicolas Weissenbach, Quentin Vecchio
--		@version 1.0.0.0
--		@date 22-06-2013
--
-----------------------------------------------------------------------------------------

with gestionBloc, mstring, definitions,liste;
use gestionBloc, mstring, definitions;

package conversion is

--
--	procedure principale qui commence la conversion d'un bloc en appelant des fonctions de conversion
--	@param listeBloc, la liste de bloc a convertir en ada
--	@return listeligne, l'ensemble des lignes en ada
--
procedure conversionAda(listeBloc : in out T_TAB_BLOC; listeLigne : in out T_TAB_LIGNE);

--
--	procedure de conversion d'un COMMENTAIRE
--	@param m_bloc, le bloc commentaire a convertir
--	@return ligne, la liste des lignes déjà converti avec à la fin le commentaire converti
--
procedure conversionCommentaire(m_bloc : in out Bloc; Ligne : in out T_TAB_LIGNE);

--
--	procedure de conversion d'un bloc AFFECTATION
--	@param m_bloc, l'affectation à convertir en ada
--	@return ligne, la liste des lignes déjà converti avec l'affectation ajouté à la fin
--
procedure conversionAffectation(m_bloc : in out Bloc; Ligne : in out T_TAB_LIGNE);

--
--	procedure de conversion d'un bloc MODULE
--	@param m_bloc, le module à convertir
--	@return ligne, la liste des lignes déjà converti avec le ou les lignes nécessaires
-- pour définir l'appel du module
--
procedure conversionModule(m_bloc : in out Bloc; Ligne : in out T_TAB_LIGNE);

--
--	procedure de conversion d'un bloc POUR
--	@param m_bloc, le bloc pour a convertir
--	@return ligne, la liste des lignes avec le bloc pour à la fin
--
procedure conversionPour(m_bloc : in out Bloc; Ligne : in out T_TAB_LIGNE);

--
--	procedure de conversion d'un bloc TANT QUE
--	@param m_bloc, le bloc tq à convertir
--	@return ligne, la liste avec la boucle à la fin
--
procedure conversionTantque(m_bloc : in out Bloc; Ligne : in out T_TAB_LIGNE);

--
--	procedure de conversion d'un bloc REPETER
--	@param m_bloc, le bloc repeter à convertir
--	@return ligne, la liste avec la boucle à la fin
--
procedure conversionRepeter(m_bloc : in out Bloc; Ligne : in out T_TAB_LIGNE);

--
--	procedure de conversion d'un bloc CONDITION
--	@param m_bloc, le bloc conditionnel a convertir
--	@return ligne, la liste des lignes déjà converti avec le bloc à la fin
--
procedure conversionCond(m_bloc : in out Bloc; Ligne : in out T_TAB_LIGNE);

--
--	procedure de conversion d'un bloc SI
--	@param m_bloc, le bloc si a convertir
--	@return ligne, la liste avec le bloc si à la fin
--
procedure conversionSi(m_bloc : in out Bloc; Ligne : in out T_TAB_LIGNE);

--
--	procedure de conversion d'un bloc SINONSI
--	@param m_bloc, le bloc sinonsi a convertir
--	@return ligne, la liste avec le bloc sinonsi à la fin
--
procedure conversionSinonSi(m_bloc : in out Bloc; Ligne : in out T_TAB_LIGNE);

--
--	procedure de conversion d'un bloc SINON
--	@param m_bloc, le bloc sinon a convertir
--	@return ligne, la liste avec le bloc sinon à la fin
--
procedure conversionSinon(m_bloc : in out Bloc; Ligne : in out T_TAB_LIGNE);

--
--	procedure de conversion d'un bloc CAS PARMI
--	@param m_bloc, le bloc cas parmis a convertir
--	@return ligne, la liste des lignes avec à la fin le cas parmis
--
procedure conversionCasParmi(m_bloc : in out Bloc; Ligne : in out T_TAB_LIGNE);

--
--	procedure de conversion d'un élément du cas parmis (une condition)
--	@param m_bloc, le bloc a convertir
--	@return ligne, la liste des lignes avec le morceau du cas parmis traduit à la fin
--
procedure conversionCasParmisInt(m_bloc : in out Bloc; Ligne : in out T_TAB_LIGNE);

end conversion;

with gestionBloc, mstring, definitions,liste;
use gestionBloc, mstring, definitions;

--------------------------------------
-- SPECIFICATION PACKAGE CONVERSION --
--------------------------------------

package conversion is

--procedure principale qui commence la conversion d'un bloc en appelant des fonctions de conversion
procedure conversionAda(listeBloc : in out T_TAB_BLOC; listeLigne : in out T_TAB_LIGNE);

--procedure de conversion d'un COMMENTAIRE
procedure conversionCommentaire(m_bloc : in out Bloc; Ligne : in out T_TAB_LIGNE);

--procedure de conversion d'un bloc AFFECTATION
procedure conversionAffectation(m_bloc : in out Bloc; Ligne : in out T_TAB_LIGNE);

--procedure de conversion d'un bloc MODULE
procedure conversionModule(m_bloc : in out Bloc; Ligne : in out T_TAB_LIGNE);

--procedure de conversion d'un bloc POUR
procedure conversionPour(m_bloc : in out Bloc; Ligne : in out T_TAB_LIGNE);

--procedure de conversion d'un bloc TANT QUE
procedure conversionTantque(m_bloc : in out Bloc; Ligne : in out T_TAB_LIGNE);

--procedure de conversion d'un bloc REPETER
procedure conversionRepeter(m_bloc : in out Bloc; Ligne : in out T_TAB_LIGNE);

--procedure de conversion d'un bloc CAS PARMI
procedure conversionCasParmi(m_bloc : in out Bloc; Ligne : in out T_TAB_LIGNE);

end conversion;

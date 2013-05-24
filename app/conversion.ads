with gestionBloc, mstring, definitions;
use gestionBloc, mstring, definitions;

--------------------------------------
-- SPECIFICATION PACKAGE CONVERSION --
--------------------------------------

package conversion is

--procedure principale qui commence la conversion d'un bloc en appelant des fonctions de conversion
procedure conversionAda(tabBloc : in out T_TAB_BLOC; tabLigne : out T_TAB_LIGNE);

--procedure de conversion d'un COMMENTAIRE
procedure conversionCommentaire(tabBloc : in out T_TAB_BLOC; tabLigne : out T_TAB_LIGNE);

--procedure de conversion d'un bloc AFFECTATION
procedure conversionAffectation(tabBloc : in out T_TAB_BLOC; tabLigne : out T_TAB_LIGNE);

--procedure de conversion d'un bloc MODULE
procedure conversionModule(tabBloc : in out T_TAB_BLOC; tabLigne : out T_TAB_LIGNE);

--procedure de conversion d'un bloc POUR
procedure conversionPour(tabBloc : in out T_TAB_BLOC; tabLigne : out T_TAB_LIGNE);

--procedure de conversion d'un bloc TANT QUE
procedure conversionTantque(tabBloc : in out T_TAB_BLOC; tabLigne : out T_TAB_LIGNE)

--procedure de conversion d'un bloc REPETER
procedure conversionRepeter(tabBloc : in out T_TAB_BLOC; tabLigne : out T_TAB_LIGNE)

--procedure de conversion d'un bloc CAS PARMI
procedure conversionCasParmi(tabBloc : in out T_TAB_BLOC; tabLigne : out T_TAB_LIGNE)

end conversion;

with mstring, gestionbloc, definitions;
use mstring, gestionbloc, definitions;


Package debug is

function GetType(ligne: chaine)return T_type_ligne;


function debuggage(tab: in out T_tab_ligne; descrErrors : in out T_Tab_Ligne)return boolean;





function debug_aff(L : in chaine; descr: in out T_Tab_Ligne) return boolean;

function debug_Mod(L : in chaine; descr: in out T_Tab_Ligne) return boolean;

function debug_Pour(L : in chaine; descr: in out T_Tab_Ligne) return boolean;

function debug_tq(L : in chaine; descr: in out T_Tab_Ligne) return boolean;

function debug_repeter(L : in chaine; descr: in out T_Tab_Ligne) return boolean;

function debug_cond(L : in chaine; descr: in out T_Tab_Ligne) return boolean;

function debug_case(L : in chaine; descr: in out T_Tab_Ligne) return boolean;



function estUneVariable(ch: chaine) return boolean;

procedure afficheErrors(descr : T_Tab_ligne);

procedure SplitChaine(c : in out Chaine; chaineSplit : in out T_Tab_Ligne);


end debug;

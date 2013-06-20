with mstring, gestionbloc, definitions;
use mstring, gestionbloc, definitions;


Package debug is

function GetType(ligne: chaine)return T_type_ligne;


procedure debuggage(tab: in out T_tab_ligne);





function debug_aff(L : in chaine) return boolean;

function debug_Mod(L : in chaine) return boolean;

function debug_Pour(L : in chaine) return boolean;

function debug_tq(L : in chaine) return boolean;

function debug_repeter(L : in chaine) return boolean;

function debug_cond(L : in chaine) return boolean;

function debug_case(L : in chaine) return boolean;



function estUneVariable(ch: chaine) return boolean;


end debug;

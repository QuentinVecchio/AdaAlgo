with mstring, simple_io, text_io, definitions;
use mstring, simple_io,definitions;

package generateur is

	procedure enregistrer(chemin: string; algo, variable: T_Tab_ligne);

	procedure ouvrir(chemin: string; algo, variable: in out T_Tab_ligne);

end generateur;

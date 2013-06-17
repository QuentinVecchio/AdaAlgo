with mstring, simple_io, text_io, definitions;
use mstring, simple_io,definitions;

package generateur is

	procedure creerFic(nom: string; fic: out text_io.file_type);

	procedure init(nomModule: chaine; fic: text_io.file_type);

	procedure ecrireCorps(defVariable, instructions: in out T_Tab_Ligne; fic: text_io.file_type);


	procedure fermer(nomModule: chaine; fic: in out text_io.file_type);

end generateur;

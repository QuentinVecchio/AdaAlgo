with simple_io, mstring, generateur, text_io, definitions;
use simple_io, mstring, generateur, definitions;

procedure testgenerateur is

	monFic: text_io.File_type;

	def, inst : T_Tab_Ligne;

	begin

		def :=Creer_liste;
		Ajout_queue(def,createChaine("a: integer;"));
		Ajout_queue(def,createChaine("type t is (lundi, mardi, mercredi);"));
		Ajout_queue(def,createChaine("age: integer;"));
		Ajout_queue(def,createChaine("nom: string;"));
		inst := Creer_liste;

		Ajout_queue(inst,createChaine("a:= 5;"));
		Ajout_queue(inst,createChaine("put_line(a);"));
		Ajout_queue(inst,createChaine("a := a+5;"));
		Ajout_queue(inst,createChaine("put_line(nom);"));
		put_line("Bienvenue");
		creerFic("test.txt", monFic);
		init(createChaine("monModule"), monFic);
		ecrirecorps(def, inst, monFic);
		fermer(createChaine("monModule"), monFic);
end testgenerateur;

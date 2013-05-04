package definitions is

	--
	--	Type d'élément que l'on peut rencontrer dans un algo
	-- 	Remarque: 	- blocCond correspond au bloc de si jusqu'à fsi
	--				- blocCase correspond au bloc de cas parmis jusqu'à fcas.
	--
	type T_elmt is (si, sinonsi, sinon, pour, tq, repeter, affectation, module, commentaire, blocCond, blocCase, defaut);

end definitions;

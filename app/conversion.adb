package body conversion is

	procedure conversionAda(tabBloc : in out T_TAB_BLOC, tabLigne : out T_TAB_LIGNE) is
	begin

	end conversionAda;
	
	procedure conversionCommentaire(eltAlgo : in chaine, eltAda : out chaine) is
	begin
		eltAda = "--" + eltAlgo;
	end conversionCommentaire;
	
	procedure conversionAffectation(tabBloc : in chaine, tabLigne : out T_TAB_LIGNE) is
	begin
	end conversionAffectation;

	procedure conversionModule(tabBloc : in chaine, tabLigne : out T_TAB_LIGNE) is
	begin
	end conversionModule;

end conversion;

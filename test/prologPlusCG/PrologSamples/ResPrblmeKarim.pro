testProfondeur(_probleme,_mouvements) :-
        
etatInitial(_probleme,_etat),
        
resoudreProfondeur(_etat,[_etat],_mouvements).


resoudreProfondeur(_etat,_historique,[]) :-
        
etatFinal(_etat).



resoudreProfondeur(_etat,_historique,[_mouvement|_mouvements]) :-
        
appliquerOperateur(_etat,_mouvement),
        
mettreAJour(_etat,_mouvement,_etat1),
        
etatLegal(_etat1),
        
non(membre(_etat1,_historique)),
        
resoudreProfondeur(_etat1,[_etat1|_historique],_mouvements).



appliquerOperateur([_avant,_apres],vertadroite) :-
        
dernier(_avant,"V").

appliquerOperateur([_avant,_apres],rougeagauche) :-
        
premier(_apres,"R").

appliquerOperateur([_avant,_apres],vertchevaucherouge) :-
        
avantDernier(_avant,"V"),
        
dernier(_avant,"R").

appliquerOperateur([_avant,_apres],rougechevauchevert) :-
        
premier(_apres,"V"),
        
second(_apres,"R").


mettreAJour([_avant,_apres], vertadroite, [_avant1,_apres1]) :-
        
conc(_avant1,["V"],_avant),
        
conc(["V"],_apres,_apres1).
mettreAJour([_avant,_apres], rougeagauche, [_avant1,_apres1]) :-
        
conc(_avant,["R"],_avant1),
        
conc(["R"],_apres1,_apres).

mettreAJour([_avant,_apres], vertchevaucherouge, [_avant1,_apres1]) :-
        
conc(_avant1, ["V","R"],_avant),
        
conc(["R","V"],_apres,_apres1).

mettreAJour([_avant,_apres], rougechevauchevert, [_avant1,_apres1]) :-
        
conc(_avant, ["R","V"],_avant1),
        
conc(["V","R"],_apres1,_apres).


etatLegal([_g,_d]).



etatInitial(sept_billes,[["V","V","V"],["R","R","R"]]).


etatFinal([["R","R","R"], ["V","V","V"]]).


conc([],_L,_L).

conc([_x|_L1],_L2,[_x|_L3]) :- 
conc(_L1,_L2,_L3).



premier([_x|_L],_x).


second([_x,_y|_R],_y).



dernier([_x],_x).

dernier([_x|_R],_y) :- dernier(_R,_y).



avantDernier([_x,_y],_x).

avantDernier([_x,_y|_R],_z) :- avantDernier([_y|_R],_z).



non(_p) :- _p, !, fail.

non(_p).



membre(_e, [_e|_]).
membre(_e, [_|L]) :- membre(_e, L).


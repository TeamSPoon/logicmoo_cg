// ELIZA : Simuler un dialogue entre un psychiatre et un patient, bas� sur le Pattern-Matching 
// Exemple de dialogue:
// Patient: Je suis toujours en d�saccord avec mes parents.
// Medecin: Etes-vous venu me voir parce que vous etes toujours en d�saccord avec vos parents ?
// Patient: Je pense que mes parents me detestent.
// Medecin: D�veloppez vos sentiments.
// ...
// - Je ne peux pas vous expliquer mon probl�me.
// - Est ce que vous avez peur de me raconter ce qui vous angoisse ?
// - Non.
// - Dites-vous non juste pour etre negatif ?
// - Non,
// - Vous etes un peu pessimiste !
// - vous etes g�nial.
// - Qu'est-ce qui vous fait croire que je suis genial ?
// ...


// Analyse par pattern-matching utilise un dictionnaire de patterns: chaque entr�e d'un tel dictionnaire est un
// couple dont le premier �l�ment est un pattern d'entr�e et le second �l�ment une liste de patterns de sortie,
// si la phrase en entr�e match/s'apparie au pattern d'entr�e, un des patterns en sortie sera choisie comme r�ponse
// Notons qu'en g�n�ral, les deux patterns E/S partagent des variables qui simulent l'esprit d'un dialogue ...

dict([y, "je", "ne", "peux", "pas", x, "probl�me", z, "."],
     [["est ce que vous avez peur de me raconter ce qui vous angoisse ?"],
      ["peut �tre vous vous sentez angoiss� de ", x, " probl�me", z]]).
dict([y, "je", "ne", "peux", "pas", x],
     [["vous n'aimez vraiment pas ", x],
      ["pourquoi ne voulez-vous pas ", x],
      ["souhaitez-vous pouvoir ", x],
      ["est-ce que cela vous ennuit"]]).
dict([y, "pere", x, "."],
     [["parlez-moi plus de votre famille"],
      ["qui encore dans votre famille", x]]).
dict([y, "mere", x, "."],
     [["parlez-moi plus de votre famille"],
      ["qui encore dans votre famille", x]]).
// ...
dict([x, "."],
     [["pouvez-vous etre plus explicite sur ce qui vous effraie ?"],
      ["qu'est-ce que cela vous suggere ?"],
      ["je vois"],
      ["je ne suis pas sur de bien vous comprendre"],
      ["continuez, soyez plus explicite"],
      ["pouvez-vous d�velopper ce point ?"],
      ["C'est tr�s interessant"]]).

// dict de certaines particules linguistiques
// dans un dialogue, on peut avoir: 
// - je te regarde
// - pourquoi me regarde tu ?
transforme("vous", "je").
transforme("etes", "suis").
transforme("suis", "etes").
// ...
transforme("me", "vous").
transforme("te", "me").

// Le but patternMatch est le coeur de l'application:
// TantQue la phrase en entr�e n'est pas "bye", faire:
// 1- chercher une entr�e dans le dict des patterns:
// 2- determine ensuite le rang de l'entr�e en sortie � activer
// 3- Afficher le pattern en sortie choisie en consid�rant les transformations des particules linguistiques
// 4- On m-�-j le rang afin de choisir la prochaine sortie 

// Le but match(phrase, pattern) est une variante/extension de l'unification de Prolog; il est d�fini comme suit:
// 1- si on arrive au dernier �l�ment du pattern et si on peut l'unifier avec le reste de la phrase, le matching 
//    se terminera alors avec succ�s.
// 2- si l'�l�ment courant du pattern est une constante et qu'il est �quivalent � l'�l�ment courant de la phrase,
//    on poursuit alors le matching avec le reste de la phrase et du pattern.
// 3- si l'�l�ment courant du pattern est une variable, l'�l�ment courant doit s'instancier � la sous-liste de la //    phrase; cette sous-liste �tant d�limit�e par l'�l�ment suivant dans le pattern. On poursuit ensuite le
//    matching avec le reste de la phrase et du pattern.
// 4- Si aucun des cas pr�c�dents ne r�ussit, conclure l'�chec du matching
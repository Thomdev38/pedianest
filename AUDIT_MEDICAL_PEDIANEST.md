# Audit médical comparatif de Pedianest — version française

26 septembre 2026 — État local du dépôt, HEAD `ac11288` et modifications préexistantes. **Aucune correction clinique ou logicielle dans cette passe.** Audit documentaire et logiciel en anesthésie pédiatrique, destiné à examen avant modification ; il ne constitue pas un protocole de prescription validé.

## Périmètre, preuves et conventions

Lecture des formules et affichages français, comparaison avec les 16 pages du « Ti' Pierre pratique / guide de survie en anesthésie du marmaille », Dr MARIE Anaïs. La date/édition du PDF n'est pas établie ; son utilisation comme référentiel local est l'information fournie par l'utilisateur. Pagination du fichier, couverture comprise. Lecture également des sept fiches cliniques PDF intégrées, avec inspection visuelle de leurs 12 pages. Ces fiches sont affichées telles quelles par `PdfViewer.asset`, sans adaptation au patient saisi. Navigation, informations, sources et confidentialité ne contiennent pas d'autre calcul clinique. Version anglaise exclue de l'audit clinique et inchangée.

W = poids en kg ; M = âge converti en mois ; Y = M/12 ; N0/N1/N2 = `toStringAsFixed(0/1/2)` ; brut = interpolation Dart sans formatage. Les tableaux normalisent la typographie des affichages ; l'annexe fournit les instructions et chaînes exactes avec numéros de ligne. Résultats en doses totales sauf unité temporelle explicite. `mcg` et `µg` sont équivalents.

Preuves : H = [homepage.dart](C:/Users/Thomas/Documents/GitHub/pedianest/lib/homepage.dart) (formules 257–350, affichages 939–1223) ; A = [antibiotique.dart](C:/Users/Thomas/Documents/GitHub/pedianest/lib/antibiotique.dart) (107–134) ; E = [entretien.dart](C:/Users/Thomas/Documents/GitHub/pedianest/lib/entretien.dart) ; P = [posologies_fr.dart](C:/Users/Thomas/Documents/GitHub/pedianest/lib/posologies_fr.dart) ; R = [reperes_pediatriques.dart](C:/Users/Thomas/Documents/GitHub/pedianest/lib/reperes_pediatriques.dart) ; Mém = [memo_pediatrique.dart](C:/Users/Thomas/Documents/GitHub/pedianest/lib/memo_pediatrique.dart). Fiches dans [assets/pdf](C:/Users/Thomas/Documents/GitHub/pedianest/assets/pdf).

CONFORME signifie correspondance documentaire pour la valeur et le contexte mentionnés, pas validation médicale universelle ou actualisée. ABSENT DU REFERENTIEL signifie non documenté dans le Ti' Pierre, pas nécessairement faux. INCOHERENT désigne une contradiction démontrable entre calcul/aide/affichage/sources internes. Les erreurs dites probables et les valeurs A VERIFIER MEDICALEMENT nécessitent un arbitrage ; les actions proposées ci-dessous n'ont pas été appliquées.

## 1. ERREURS CERTAINES

Ce sont des défauts logiciels/documentaires démontrables, et non l'affirmation que toute administration correspondante serait nécessairement erronée.

1. **Plafonds annoncés non appliqués** : amoxicilline/acide clavulanique 50 kg → 2 500 mg malgré max 2 g ; céfoxitine 60 kg → 2 400 mg malgré max 2 g ; clindamycine 100 kg → 1 000 mg malgré max 900 mg ; ibuprofène 50 kg → 500 mg malgré max 400 mg/prise. Aucun contrôle d'entrée n'exclut ces poids. Clonazépam 30 kg → 1,5 mg alors que le PDF limite à 1 mg ; ce plafond n'est pas dans l'aide.
2. **Calcul différent de l'aide** : kétamine d'induction 2–4 mg/kg contre aide 2 mg/kg IV ; sufentanil 0,2–0,4 µg/kg contre aide 0,2 seulement.
3. **Actiskenan et Skenan LP** : W mg est la quantité quotidienne du PDF. Le résultat ne porte que « mg », l'aide précise pourtant 6 ou 2 prises/j. À 12 kg, 12 mg/j ne signifie pas 12 mg par prise. Défaut d'étiquetage temporel, pas preuve d'un multiplicateur W faux.
4. **Saisie** : `int.tryParse(...) ?? 0` transforme `3.5`, `3,5`, vide ou texte en zéro ; les entiers négatifs sont acceptés. Les poids fractionnaires ne sont pas pris en charge. Après édition des champs ou de l'unité d'âge, les anciens résultats persistent jusqu'au recalcul.
5. **PDF anaphylaxie p.2, adrénaline IVSE** : 1 mg dans 50 ml donne 20 µg/ml. À 0,1 µg/kg/min, débit = 0,3W ml/h. Le tableau imprimé 5/10/15/20/30 kg donne 1,6/3,3/5/6,6/10 ml/h au lieu de 1,5/3/4,5/6/9. Écart d'environ 7–11 %, confirmé visuellement. Incohérence du document embarqué, pas d'une formule Dart.
6. **Contradictions internes** : défibrillation initiale 2 J/kg dans calculette/Ti' Pierre contre 4 dans fiche ACR ; bupivacaïne 2,5 mg/kg/6 h en ALR contre maximum 2 mg/kg dans fiche toxicité AL ; volume sanguin 95 ml/kg attribué à tout nouveau-né par le code, alors que le PDF réserve 95 au prématuré et 90 au nouveau-né.

## 2. ERREURS PROBABLES

- **Fentanyl 20–50 µg/kg en induction générique** : rechercher explicitement un éventuel facteur 10. Il n'est pas démontré : des techniques anesthésiques à fortes doses existent. Ne pas diviser automatiquement par 10. Provenance clinique pédiatrique introuvable dans le dépôt.
- **Rémifentanil 0,2–0,5 µg/kg** : bolus/perfusion non précisés. Une omission de `/min` est une hypothèse, pas une correction établie. L'intitulé global suggère induction, sans preuve que telle soit l'intention initiale.
- **PDF néonatal : glycémie `<0,3 g/dL`**, soit 3 g/L. Forte suspicion d'erreur d'unité facteur 10. Le seuil et son contexte doivent être validés ; ne pas remplacer automatiquement par 0,3 g/L.
- **Ti' Pierre p.14 : glucose d'entretien `0,25–0,75 mg/kg/h`** : unité/ordre de grandeur à vérifier avec le référent. Non repris comme calcul dans l'application ; ne pas recopier ultérieurement sans arbitrage.
- **Arrondis** : rocuronium 1 kg, 0,6–1,2 mg → « 1 - 1 mg » ; clonazépam 1 kg, 0,05 mg → 0,1 mg. Multiplicateurs conservés mais perte d'information importante chez les petits poids.

## 3. ECARTS AU REFERENTIEL LOCAL

À arbitrer : succinylcholine 1 mg/kg dès 18 mois contre 1,5 enfant ; AL `/6h` absent du PDF et bupivacaïne 2,5 contre habituelle 2 ; entretien Exacyl masqué dès 30 kg malgré le « puis 10 mg/kg/h » non explicitement limité dans le PDF ; matériel calculé selon d'autres règles que le mémo ; prématurité remplacée par âge chronologique pour le volume sanguin.

Le texte actuel sur l'absence de compensation systématique du jeûne diffère de Berry p.7 ; cet écart résulte d'une demande antérieure et ne doit pas être annulé automatiquement. Le calcul pondéral de la lame a aussi été conservé explicitement à la demande de l'utilisateur. La conformité à un PDF dont l'édition n'est pas établie ne justifie pas à elle seule de rétablir une pratique, notamment ISR, colloïdes ou réanimation.

## 4. VALEURS ABSENTES DU PDF

Pas de référentiel d'induction générale propofol/étomidate ou des quatre opioïdes, pas de posologie cisatracurium/atracurium, des sept antibiotiques ou prilocaïne, pas d'intervalle AL `/6h`, pas de tableau complet pondéral ballon ou sonde urinaire. Les sept algorithmes d'urgence ne sont pas entièrement décrits par le Ti' Pierre. Une dose de propofol pour laryngospasme ne valide pas toute induction.

## 5. VALEURS CORRECTES

Concordance documentaire/arithmétique, avec limites détaillées plus bas : conversion âge ; PAS 70+2Y après un an ; tableau des constantes ; Guedel/mémo lame/masque ; circuit aux bornes 5 et25 kg ; règle 4-2-1 ; pertes chirurgicales ; morphine charge/titration ; coefficients nalbuphine ; phényléphrine en µg ; PFC/plaquettes ; dilutions noradrénaline/dobutamine ; mannitol/diazépam dans les contextes indiqués.

Aucun couple minimum/maximum contrôlé n'est inversé pour W>0. Fibrinogène désormais croissant 0,03–0,06 g/kg ; la borne haute est néanmoins dérivée du doublement 2→4 ml/kg dans le PDF, sous hypothèse de concentration constante, et non écrite directement en g/kg.

## 6. POINTS NECESSITANT UNE VALIDATION MEDICALE EXTERNE

Priorités : fentanyl, rémifentanil, alfentanil, AL et intervalles, antibioprophylaxie par indication/âge, plafonds, formes/concentrations calcium et SSH, nouveau-né/prématuré, puis harmonisation des fiches. Définir également la transition pédiatrie/adolescence et le poids de dosage.

### Sources externes ciblées : RCP officiels, contexte pédiatrique

Ces vérifications ne constituent pas une validation externe de toutes les autres molécules.

- **Fentanyl injectable** : chez les 2–11 ans en anesthésie équilibrée, induction 1–3 µg/kg IV et entretien 1–2 dans le RCP consulté. Des régimes adultes à fortes doses existent pour d'autres techniques. Cela justifie l'investigation du 20–50 générique et du facteur 10, sans démontrer une faute de frappe. [RCP Fentanyl Renaudin](https://m.base-donnees-publique.medicaments.gouv.fr/rcp-68104646-9).
- **Rémifentanil** : chez les 1–12 ans, entretien décrit avec bolus 1 µg/kg sur au moins 30 secondes et perfusions dépendant de l'anesthésique associé, notamment début à 0,25 µg/kg/min. Induction avec hypnotique IV non recommandée faute de données dans ce RCP ; limites également avant un an. L'indication et le mode d'administration manquent dans l'application. [RCP Rémifentanil Viatris](https://base-donnees-publique.medicaments.gouv.fr/medicament/68115596/extrait).
- **Sufentanil** : au-delà d'un mois, induction 0,2–0,5 µg/kg sur au moins 30 secondes avec un autre anesthésique. La plage calculée est incluse mais aide, durée et absence de limite néonatale sont à préciser. [RCP Sufentanil](https://base-donnees-publique.medicaments.gouv.fr/medicament/60460398/extrait).
- **Alfentanil** : chez l'enfant plus âgé, bolus initial notamment 10–20 µg/kg et compléments 5–10. Le 20–40 nécessite une justification propre au contexte pédiatrique retenu. [RCP Rapifen](https://m.base-donnees-publique.medicaments.gouv.fr/rcp-68622560-0).

### Provenance dans Git

Les quatre coefficients opioïdes apparaissent dans `29b1098e73cd9049c6c2c36a32d4de7c4c648fc9` (« reprise », 12 janvier 2025). Recherche `git log --all -S` et lecture de leur introduction : pas de référence clinique, commentaire bolus/perfusion ou indication spécifique retrouvés.

AL `/6h` présent dès `f4af74af0c96e902a426df119f6a40241b49f8a7` (« antb et alr », 14 janvier 2025). Origine logicielle identifiée, justification médicale non retrouvée. La bibliographie générale de `lib/sources.dart` (Vidal, ADARPEF, SFAR, ouvrages…) ne rattache pas une édition/page aux coefficients, plafonds et réinjections. Elle ne valide donc pas chaque posologie.

## Tableau comparatif

Les chaînes exactes et formules sources sont reproduites en annexe. Les actions suivantes restent des propositions à examiner.

### Saisie, hypnotiques, morphiniques et curares

| Section | Élément | Code actuel | Affichage | Référence Ti' Pierre | Statut | Action proposée |
|---|---|---|---|---|---|---|
| Saisie | Poids | H : int.tryParse ou0 | kg ; pas de fractions ; zéro/négatifs possibles | Population incluant néonatologie | INCOHERENT | Validation positive/fractionnaire avant calcul. |
| Saisie | Âge | R : mois ou12×années, entier | Mois/années ; pas de borne haute ni SA | p.6/11 : âges chronologique et postconceptionnel | A VERIFIER MEDICALEMENT | Domaine pédiatrique et paramètres néonataux à définir. |
| Saisie | Mois/années | PAS :70+2(M/12) ; IOT :M/12/2+12 | PAS et repère IOT | p.6 :70+2Y | CONFORME | Pas d'erreur facteur12 ; cela ne valide pas la méthode IOT. |
| Saisie | Résultat après édition | Recalcul seulement sur Calculer | Anciennes doses jusqu'au recalcul | Sans objet | INCOHERENT | Invalider/identifier le résultat après édition des entrées. |
| Transversal | Intitulé global | H : Doses Induction | Inclut aussi postopératoire et urgences | Contextes séparés | INCOHERENT | Distinguer les indications cliniques. |
| Transversal | Min/max | Multiplicateurs croissants si W>0 | Inversion/doses négatives si W<0 | Sans objet | INCOHERENT | Rejeter W invalide ; plages positives cohérentes. |
| Transversal | mg/mcg/µg | Adrénaline0,01mg/kg=10µg ; atropine0,02=20 | Unités variables, mcg=µg | p.13 concordant | CONFORME | Harmonisation éventuelle sans modification injustifiée des doses. |
| Transversal | Arrondis | N0 rocuronium, N1 petites doses | 1 kg : roc1–1mg ; clonazépam0,1mg | Pas d'arrondi prescrit | INCOHERENT | Définir précision par produit/poids. |
| Transversal | Puberté/plafonds | Pas de contrôle global | Multiplication même poids élevé | p.14 doses adultes à puberté | A VERIFIER MEDICALEMENT | Poids de dosage et maxima par molécule. |
| Hypnotiques | Propofol | 2W–5W | Brut mg ; aide2–5mg/kg | Induction absente | ABSENT DU REFERENTIEL | Source pédiatrique/âge/voie à établir. |
| Hypnotiques | Étomidate | 0,2W | N1 mg ; aide0,2mg/kg | Absent | ABSENT DU REFERENTIEL | Valider âge/indication. |
| Hypnotiques | Kétamine induction | 2W–4W | N0 mg ; aide2mg/kg induction IV | Plage absente | INCOHERENT | Arbitrer calcul/aide/voie. |
| Hypnotiques | Kétamine anti-NMDA | 0,2W | N1 mg ; aide0,2mg/kg sans /h | p.12 :0,15–0,5mg/kg/h périop ;1mg/kg/j postop | A VERIFIER MEDICALEMENT | Bolus non validé par passage sur perfusion. |
| Hypnotiques | Propofol entretien | 10W, variable transmise | Pas de dose clinique d'entretien affichée | Absent | ABSENT DU REFERENTIEL | Ne pas qualifier cette variable dormante de prescription. |
| Morphiniques | Fentanyl | 20W–50W | Brut mcg ;20–50mcg/kg ; induction sans filtre d'âge | Absent | A VERIFIER MEDICALEMENT | Priorité : source et hypothèse facteur10, sans division automatique. |
| Morphiniques | Rémifentanil | 0,2W–0,5W | N1 µg ;0,2–0,5µg/kg, ni /min ni bolus | Absent | ERREUR PROBABLE D'UNITE | Omission /min hypothétique ; préciser mode/âge/indication. |
| Morphiniques | Sufentanil | 0,2W–0,4W | Sufentanyl N1 mcg ; aide0,2mcg/kg seule | Absent | INCOHERENT | Harmoniser après validation ; préciser durée/néonatologie. |
| Morphiniques | Alfentanil | 20W–40W | Alfentanyl brut mcg ;20–40mcg/kg | Absent | A VERIFIER MEDICALEMENT | Justifier plage pédiatrique ; voir RCP ciblé. |
| Curares | Cisatracurium | 0,2W | N1 mg ; aide0,15–0,2mg/kg | Absent | ABSENT DU REFERENTIEL | Source ; choix borne haute à expliciter. |
| Curares | Succinylcholine M<18 | 2W | Celocurine mg ;2mg/kg | p.14 nouveau-né/nourrisson2 | A VERIFIER MEDICALEMENT | Coefficient concordant ; justifier frontière18mois. |
| Curares | Succinylcholine M≥18 | W | Celocurine mg ;1mg/kg | p.14 enfant1,5mg/kg | INCOHERENT | Arbitrer coefficient et frontière. |
| Curares | Atracurium | 0,5W | N1 mg ;0,5mg/kg | Absent | ABSENT DU REFERENTIEL | Source pédiatrique. |
| Curares | Rocuronium | 0,6W–1,2W | N0 mg ;0,6 ou1–1,2mg/kg ISR | p.14 ISR non recommandé dans ce PDF | A VERIFIER MEDICALEMENT | Référentiel actuel, âge et arrondi ; ne pas revenir automatiquement à un ancien protocole. |

### Cardiovasculaire, antalgiques et antiémétiques

| Section | Élément | Code actuel | Affichage | Référence Ti' Pierre | Statut | Action proposée |
|---|---|---|---|---|---|---|
| Cardio | Adrénaline | 0,01W | N2 mg sans indication/voie | p.13 ACR10–30µg/kgIV | A VERIFIER MEDICALEMENT | Correspond borne basse ACR ; pas dose générique d'induction/anaphylaxie. |
| Cardio | Atropine | 0,02W | N2 mg sans voie | p.13 20µg/kg | CONFORME | Compléter contexte/voie/plafond si source externe. |
| Cardio | Phényléphrine | P :0,5W–2W | N1 min/brut max µg ; bolus ; maximum10µg/kg | p.13 identique | CONFORME | Plage sous maximum ; pas de cumul calculé. |
| Cardio | Amiodarone | 5W | Cordarone mg IVL20min | p.13 identique | CONFORME | Distinguer contexte IVD fiche ACR et plafonds. |
| Cardio | Noradrénaline | Texte0,15Wmg dans25ml | 1ml/h=0,1mcg/kg/min ;0,05–2mcg/kg/min | p.13 identique | CONFORME | Égalité dimensionnelle vérifiée. |
| Cardio | Dobutamine | Texte15Wmg dans25ml | 0,1ml/h=1mcg/kg/min ;5–20mcg/kg/min | p.13 identique | CONFORME | Égalité dimensionnelle vérifiée. |
| Cardio | Éphédrine | Texte300µg/kg | 300µg/ml si<10kg, non diluée>10 ; moins efficace<1an | p.13 identique | ECART MINEUR | Cas10kg non défini dans les deux supports. |
| Cardio | Lidocaïne | Texte, pas de total | Xylocaine1mg/kg | p.13 identique | CONFORME | Distinguer antiarythmique/ALR/toxicité AL. |
| Cardio | Défibrillation | Texte | 2J/kg puis4 si échec | p.13 identique ; fiche ACR initial4 | INCOHERENT | Harmoniser référentiel validé. |
| Antalgie | Paracétamol | 15W tout âge | N0 mg ;15mg/kg | p.11 ≥44SAPC15×4/j ;32–44 charge20 puis10/6h | A VERIFIER MEDICALEMENT | SAPC non saisi, voie/intervalle/plafond manquants. |
| Antalgie | Kétoprofène | W si M≥12 | Profenid mg ;0,5–1mg/kg | p.11 IV/8h ; AMM15ans, extension hors AMM≥1an | ECART MINEUR | Borne haute, intervalle/voie et hors AMM à préciser. |
| Antalgie | Ibuprofène | 10W si M≥3 | mg ;10mg/kg/8h max400mg/prise | p.11 identique | ERREUR PROBABLE DE CALCUL | Maximum non appliqué :50kg→500mg. |
| Antalgie | Nalbuphine | P :0,1W si M<6 sinon0,2W | N1 mg ; âge et coefficient affichés | p.11 IV/4–6h ;0,1<6mois hors AMM ; AMM18mois | ECART MINEUR | Coefficients corrects ; préciser IV, intervalle et contexte d'âge. |
| Antalgie | Néfopam | Texte si M≥180 | Acupan1ampoule4–6/j | p.11 identique≥15ans | CONFORME | Masse/ampoule à préciser si futur calcul. |
| Antalgie | Oramorph | 0,2W si M≥6 | N1 mg ; toutes4–6h | p.11 identique | CONFORME | Dose par prise concordante. |
| Antalgie | Actiskenan | W si M≥6 | N0 mg ; aide1mg/kg/j en6prises | p.11 quantité quotidienne | INCOHERENT | Résultat doit distinguer quantité/j et quantité/prise après validation. |
| Antalgie | Skenan LP | W si M≥6 | N0 mg ; aide1mg/kg/j en2prises | p.11 quantité quotidienne | INCOHERENT | Même ambiguïté ; respecter formulation LP. |
| Antalgie | Morphine charge | 0,1W | N1 mg IV lente ;0,1mg/kg | p.11 IVL5min | ECART MINEUR | Coefficient correct ; durée5min non affichée. |
| Antalgie | Morphine titration | 25W–50W | µg par bolus, réévaluation5min après charge | p.11 identique | CONFORME | Préserver distinction charge/titration. |
| Antagoniste | Naloxone | Cible10Wµg ; bolus40 ; entretien10Wµg/h | Ampoule0,4mg « dans10ml » | p.12 1ml+9SSI=40µg/ml, jusqu'à10µg/kg puis10µg/kg/h | A VERIFIER MEDICALEMENT | Volume final ambigu ; W<4kg :40µg dépasse cible10W. |
| Antiémétiques | Dexaméthasone | 0,15W si M≥24 | N1 mg ;0,15mg/kg | p.12 idem, AMM2ans | CONFORME | Plafond/voie externes non établis ici. |
| Antiémétiques | Ondansétron | 0,1W si M≥1 | N1 mg ; aide « 0.1 mg/ x 3/jour » | p.12 0,1mg/kg×3/j, AMM1mois | INCOHERENT | kg absent de l'aide ; multiplicateur correct. |
| Antiémétiques | Dropéridol | 20W si M≥24 | µg ;20µg/kg ; pas ambulatoire en aide | p.12 ≥2ans, dernière intention, non ambulatoire | ECART MINEUR | Dernière intention omise, contexte ambulatoire non filtré. |
| Autres | Phloroglucinol | W | Spasfon mg ;1mg/kg/6h, voie non affichée | p.12 1mg/kg/6h IV | ECART MINEUR | Voie IV omise ; âge/plafonds externes à vérifier. |

### Antibioprophylaxie et ALR

Sept antibiotiques, aucun autre retrouvé dans les calculs français. Contexte affiché : antibioprophylaxie, sans chirurgie/indication/allergie/fonction rénale sélectionnée. Aucun filtrage d'âge : les champs âge de A ne sont pas utilisés. Aucun maximum appliqué dans H. Pas de source spécifique par molécule dans le dépôt ; bibliographie générale seulement.

| Section | Élément | Code actuel | Affichage | Référence Ti' Pierre | Statut | Action proposée |
|---|---|---|---|---|---|---|
| Antibiotiques | Céfazoline | 30W ;A128 | mg ;30mg/kg ; même dose si>4h ; pas de max/âge | Absente | ABSENT DU REFERENTIEL | Valider source/indication/plafonds initial et réinjection. |
| Antibiotiques | Amoxicilline/ac. clavulanique | 50W ;A129 | mg ;50mg/kg max2g ;>2h même dose max1g ; aucun âge | Absente | INCOHERENT | Maximum non appliqué ; définir composant amoxicilline, ratio et réinjection distincte. |
| Antibiotiques | Clindamycine | 10W ;A130 | mg ;10mg/kg max900 ;>4h même dose max450–600 selon indications non précisées | Absente | INCOHERENT | Maximum non appliqué ; indication et plafond réinjection à sourcer ; aucun âge. |
| Antibiotiques | Gentamicine | 6W ;A131 | Gentamicyne mg ;6mg/kg dose unique ; pas de max/âge | Absente | ABSENT DU REFERENTIEL | Âge/rein/poids de dosage et indication à valider. |
| Antibiotiques | Céfoxitine | 40W ;A132 | mg ;40mg/kg max2g ;>2h même dose max1g ; aucun âge | Absente | INCOHERENT | Maximum non appliqué ; différencier initial/réinjection. |
| Antibiotiques | Métronidazole | 15W ;A133 | mg ;15mg/kg dose unique ; pas de max/âge | Absente | ABSENT DU REFERENTIEL | Valider indication, plafond, nouveau-né. |
| Antibiotiques | Vancomycine | 20W–30W ;A134 | mg ;20–30mg/kg en60min, dose unique ; pas de max/âge | Absente | ABSENT DU REFERENTIEL | Dose/vitesse maximale/rein/indication à vérifier séparément. |
| ALR | Lidocaïne | 5W ;A107 | mg/6h ;5mg/kg/6h | p.10 habituelle5 max7,5mg/kg ; pas /6h | A VERIFIER MEDICALEMENT | Dose usuelle concordante ; intervalle sans source ; fiche toxicité max6. |
| ALR | Bupivacaïne | 2,5W ;A108 | Brut mg/6h ;2,5mg/kg/6h | p.10 habituelle2 max3 | INCOHERENT | Habituelle différente ; intervalle sans source ; dépasse max2 fiche toxicité. |
| ALR | Ropivacaïne | 3W ;A109 | mg/6h ;3mg/kg/6h | p.10 habituelle2–3 max3,5 | A VERIFIER MEDICALEMENT | Coefficient dans plage ; répétition6h non justifiée ; fiche toxicité max3. |
| ALR | Prilocaïne | 5W ;A110 | mg/6h ;5mg/kg/6h | Absente | ABSENT DU REFERENTIEL | Source/âge/concentration/intervalle nécessaires. |
| ALR | Spray lidocaïne | Texte A112 | 5% ;1pulvérisation/10kg ;8mg/pulvérisation | p.10 identique | CONFORME | Aucun total ni arrondi de pulvérisations calculé. |
| ALR | Cumul/concentrations | Aucune addition des AL ni conversion mg/ml | Lignes indépendantes, tous âges | p.10 distingue technique/âge/bolus/perfusion | A VERIFIER MEDICALEMENT | Plafond de bolus ne vaut pas débit continu ou droit de répétition. |

### Fluidothérapie, transfusion et neurologie

| Section | Élément | Code actuel | Affichage | Référence Ti' Pierre | Statut | Action proposée |
|---|---|---|---|---|---|---|
| Fluides | Entretien4-2-1 | R :4W si≤10 ;40+2(W−10) si≤20 ;60+W−20 sinon | ml/h ; trois tranches | p.7 identique | CONFORME | Bornes continues :10kg40 ;20kg60ml/h. |
| Fluides | Pertes mineures | 2W | 2ml/kg/h ; Pour W kg :2W ml/h | p.7 identique | CONFORME | Aucun changement. |
| Fluides | Pertes intermédiaires | 4W–6W | 4–6ml/kg/h ; Pour W kg :plage ml/h | p.7 identique | CONFORME | Aucun changement. |
| Fluides | Pertes majeures | 6W–10W | 6–10ml/kg/h ; Pour W kg :plage ml/h | p.7 identique | CONFORME | Aucun changement. |
| Fluides | Bolus | 20W | ml sur20–30min ; aide10–20ml/kg | p.7 SSI/RL10–20 sur20–30min | ECART MINEUR | Résultat choisit borne haute ; préciser réévaluation. |
| Fluides | Solutés | Texte cristalloïde équilibré ; Isopédia sans âge précisé ; RL possible après4ans | Conseils non calculés | p.7 B66=RL+glucose1% avant4ans puisRL | A VERIFIER MEDICALEMENT | Valider substitution/formulation, besoin glucosé et borne4ans. |
| Fluides | Jeûne | Pas de compensation systématique en électif | Pas de calcul Berry | p.7 chirurgie<1h :25ml/kg<3ans,15>3 | A VERIFIER MEDICALEMENT | Écart intentionnel antérieur ; source actuelle sans retour automatique. |
| Transfusion | Volume sanguin | E :M<1 95W ;<2 90W ;<13 80W ;sinon70W | N0 ml | p.8 prématuré95, nouveau-né90,nourrisson80,enfant70 | INCOHERENT | Nécessite statut prématuré ;3kg nouveau-né à terme285ml contre270 selon PDF. |
| Transfusion | Hb normale | H :M<1 17 ;<2 14 ;<3 10–11 ;<24 12 ;<72 13,5 ;sinon14 | g/dl ; anémie physiologique à2mois | p.8 naissance17 ;1mois14 ;2mois10–11 ;6mois12 | A VERIFIER MEDICALEMENT | Premiers repères concordants ; extensions de tranches et13,5/14 non documentées. |
| Transfusion | Seuil Hb | Texte E | Nouveau-né/nourrisson10 ;enfant8 ;cyanogène12g/dl | p.8 identique | CONFORME | Repères contextuels, pas déclencheurs automatiques. |
| Transfusion | CGR | Texte3×(Hb souhaitée−observée)×W | Volume en ml, aucun calcul patient Hb | p.8 identique | CONFORME | Alternatives4ml/kg par g/dl et15ml/kg standard du PDF non affichées. |
| Transfusion | Ratios | Texte >30kg1/1/1 ;<30kg30/20/20ml/kg | CGR/PFC/PLQ | p.9 identique | ECART MINEUR | Cas30kg non défini dans les deux supports ; préciser contexte. |
| Transfusion | PFC | 10W–30W | N0 ml ;10–30ml/kg | p.9 identique | CONFORME | Min/max corrects. |
| Transfusion | Plaquettes | 15W–20W | N0 ml ;15–20ml/kg | p.9 identique | CONFORME | Min/max corrects. |
| Hémostase | Fibrinogène | P :0,03W–0,06W | N2 g ; haut si choc, non systématique | p.9 0,03g/kg ou2ml/kg, jusqu'à4ml/kg si choc | A VERIFIER MEDICALEMENT | Haut dérivé sous hypothèse même concentration ; confirmer produit/contexte. |
| Hémostase | Exacyl charge | P :W<30 10Wmg sinon1000mg | N0 mg ou1g | p.9 <30 :10mg/kg ;>30 :1g | ECART MINEUR | Extension à exactement30kg à valider. |
| Hémostase | Exacyl entretien | 10Wmg/h uniquement W<30 | Ligne masquée dès30kg | p.9 « puis10mg/kg/h » sans restriction explicite | INCOHERENT | Confirmer portée du puis ; interprétation antérieure ne prouve pas conformité. |
| Transfusion | Gluconate calcium | 7,5W–15W | N1–N0 mg ;7,5–15mg/kg | p.9 mêmes nombres | A VERIFIER MEDICALEMENT | Sel/calcium élément et concentration non précisés ; pas de conversion ml automatique. |
| Neuro | SSH | 6,5W–10W | N1–N0 ml ;6,5–10ml/kg | p.14 identique, sans concentration | A VERIFIER MEDICALEMENT | Concentration/indication indispensables à validation du volume. |
| Neuro | Mannitol | 0,5W–W | Brut g ;0,5–1g/kg sur20min | p.14 identique | CONFORME | Pas de conversion ml/concentration. |
| Neuro | Diazépam | 0,5W | Valium mg ;0,5mg/kg IR | p.14 identique | CONFORME | Max/âge externes non établis par ce passage. |
| Neuro | Clonazépam | 0,05W | Rivotril N1 mg ;0,05mg/kg IV | p.14 max1mg renouvelable1fois | ERREUR PROBABLE DE CALCUL | Max et répétition absents ;30kg→1,5mg ; contrôler arrondi petits poids. |

### Matériel, constantes et mémo

| Section | Élément | Code actuel | Affichage | Référence Ti' Pierre | Statut | Action proposée |
|---|---|---|---|---|---|---|
| Ventilation | Circuit | R :W<5 néonat ;<25 pédiatrique ;sinon adulte | Neonat/pediatrique/adulte | p.4 néonatal<5, pédiatrique<25 | CONFORME | Bornes5/25 cohérentes avec complément des classes. |
| Ventilation | Ballon | H :W≤10 0,5L ;≤20 1L ;≤30 2L ;sinon adulte | Litres ou adulte | Absent | ABSENT DU REFERENTIEL | Source du tableau. |
| Ventilation | Sonde IOT | H :W≤4 2,5–3 ;≤9 3,5 ;≤14 4 ;≤19 4,5 ;≤24 5 ;≤29 5,5 ;≤34 6 ;≤39 6,5 ;sinon7 | Taille sans unité dans valeur | p.4 D=W/10+3 et tableau par âge | INCOHERENT | Table différente du mémo ; expliciter méthode/ballonnet ; aucun changement silencieux. |
| Ventilation | Repère oral | H :Y/2+12 | N0 cm | p.4 3D ; nasal+2cm | INCOHERENT | Nouveau-né3kg :12cm contre9,9 via D indicatif3,3 ; arbitrer méthodes et âges. |
| Ventilation | Aspiration | H :W<5 6–8 ;≤10 8 ;≤15 10 ;≤20 12 ;≤35 14 ;sinon16 | Taille sans Fr dans valeur | p.4 Fr=2D | INCOHERENT | À20kg :12 contre10 via D=5 ; source et unité. |
| Ventilation | Lame calculée | H :W≤5 0–1 ;≤10 1 ;≤12 1–2 ;≤34 2 ;sinon3 | Taille lame | p.4 tableau par âge | A VERIFIER MEDICALEMENT | Méthode pondérale volontairement conservée ;6ans20kg→2 contre3 par âge. |
| Ventilation | Volume courant | 6W–8W | N0 ml ;6–8ml/kg | Absent du Ti' Pierre ; fiche ACR6–8 | ABSENT DU REFERENTIEL | Valider contexte d'anesthésie et poids de référence. |
| Matériel | Guedel calculée | R :M<1 000/00 ;<12 0 ;<60 1 ;sinon2/3 | Transparente/bleue ;grise ;blanche ;verte/orange | p.4 identique | CONFORME | À5ans tranche suivante ; conversion âge correcte. |
| Matériel | KT artériel | H :W<1 1Fr24Ga ;<10 3Fr24Ga ;<20 3Fr20Ga ;<30 4Fr20/18Ga ;sinon5Fr18Ga | Fr et Ga | p.5 <10kg3Fr24Ga ;>10kg4Fr22Ga ;pas fémorale<10kg | INCOHERENT | Vérifier type matériel, correspondances Fr/Ga et site. |
| Matériel | VVC | H :W<2 2–3Fr ;<4 3–4 ;<10 4–5 ;<20 5–6 ;<40 6–7 ;sinon7–8,5 | Fr sans longueur | p.5 âge :3Fr6cm ;3Fr8cm ;4Fr11cm ;>5Fr13–16cm | A VERIFIER MEDICALEMENT | Table pondérale non équivalente ; source/site/longueur. |
| Matériel | Sonde urinaire | H :M<1 5–6Fr ;<2 et<12 6–8 ;<36 8 ;<72 8–10 ;<120 10–12 ;<192 12–14 ;sinon14–16 | Fr | Absente | ABSENT DU REFERENTIEL | Source ; branches<2 et<12 redondantes en résultat mais atteignables. |
| Constantes | M<1 | R tableau | FC140–180 ;PA60/35 ;FR30–60 | p.6 identique | CONFORME | Contextualiser différence fiche salle de naissance. |
| Constantes | 1≤M<12 | R tableau | FC120–150 ;PA90/65 ;FR24–40 | p.6 identique | CONFORME | Aucun changement. |
| Constantes | 12≤M<24 | R tableau | FC110–130 ;PA95/65 ;FR20–30 | p.6 identique | CONFORME | Borne12mois tranche suivante. |
| Constantes | 24≤M<60 | R tableau | FC105–120 ;PA100/60 ;FR20–30 | p.6 identique | CONFORME | Borne2ans tranche suivante. |
| Constantes | 60≤M≤144 | R tableau | FC90–110 ;PA110/60 ;FR16–20 | p.6 identique | CONFORME | 12ans inclus. |
| Constantes | M>144 | R tableau | FC70–100 ;PA120/65 ;FR16–20 | p.6 identique | CONFORME | Pas de borne adulte haute. |
| Constantes | Libellé PA | Clé interne PAS contient deux pressions | PAS - PAD : systolique/diastolique | p.6 PA | CONFORME | Libellé visible correct malgré nom de clé interne imprécis. |
| Constantes | Hypotension après1an | R :M>12,70+2Y | si PAS<seuil mmHg, entier ou1décimale | p.6 identique | CONFORME | À12mois exactement aucune valeur selon >1an strict. |
| Constantes | Hypotension nouveau-né | R :M<1, texte | PAM<âge gestationnel naissance en SA | p.6 règlePAM<SA | CONFORME | Informatif ; aucune SA saisie, aucun seuil patient calculé. |
| Constantes | Hypotension1–12mois | R :aucun seuil | Ligne absente | p.6 PAS seulement>1an ; autres seuils de risque cérébral | A VERIFIER MEDICALEMENT | Ne pas remplacer par un seuil de risque différent sans validation. |
| Mémo | Circuit | Texte | <5 néonatal ;5 à<25 pédiatrique ;≥25 adulte | p.4 | CONFORME | Concordant avec résultat. |
| Mémo | Sonde | Texte | diamètre indicatif(W/10)+3 | p.4 | CONFORME | Méthode distincte de table du résultat. |
| Mémo | Repère oral | Texte | diamètreIOT×3 | p.4 | CONFORME | Méthode distincte du résultat. |
| Mémo | Aspiration | Texte | Fr≈2×diamètreIOT | p.4 | CONFORME | Méthode distincte du résultat. |
| Mémo | Guedel | Texte | Nouveau-né000/00 ;<1an0 ;1 à<5ans1 ;5–12ans2/3 ;>12ans2/3 + couleurs | p.4 | CONFORME | Borne5ans explicite, sans chevauchement avec la tranche1 à<5ans. |
| Mémo | Lame | Texte | Nouveau-né droite1/courbe0 ;<1an1 ;1 à<2ans1 ;2 à<5ans2 ;5–12ans3 ;>12ans3 | p.4 | CONFORME | Repère par âge, pas remplacement du calcul pondéral. |
| Mémo | Masque facial | Texte | Nouveau-né0 ;<1an1 ;1 à<2ans2 ;2 à<5ans3 ;5–12ans3 ;>12ans4 | p.4 | CONFORME | Aucun masque calculé séparément. |
| Mémo | Hémodynamique | Texte | >1an PAS70+2Y ;nouveau-né PAM selon GA | p.6 | CONFORME | Pas de seuil néonatal sans GA. |

## Fiches d'urgence intégrées : contenu affiché, non calculé

Les sept widgets de `lib/urgences/` chargent les fichiers ci-dessous. « PDF statique » dans la colonne code signifie aucune formule Dart : la règle imprimée est elle-même la formule de référence affichée. Les âges/poids des fiches ne sont pas filtrés par la saisie de l'application.

- ACR : `ACR-au-bloc-chez-l-enfant.pdf`, CAMR/ADARPEF2016, mise à jour2022, références ERC2021.
- ANA : `anaphylaxie-pediatrie.pdf`, CAMR/ADARPEF2019, références SFAR et article2015.
- HM : `HyperthermieMaligneenfant.pdf`, 2019, mise à jour2023, SFAR2019/EMHG2021.
- AL : `intoxication-Anesthesiques-Locaux-enfant.pdf`, 2019, mise à jour2022, SFAR2016/ASRA2020.
- IOT : `iot-difficile-chez-l-enfant.pdf`, CAMR2020, référence2018.
- LAR : `laryngospasmepediatrie.pdf`, CAMR/ADARPEF2019.
- NN : `reanimation-du-nouveau-ne-en-salle-de-naissance.pdf`, CAMR2020, support pédagogique SFN.

Ces dates et références sont celles imprimées dans les fichiers ; elles ne certifient pas que chaque conduite est actuelle en2026. Les liens/protocoles externes qu'ils citent n'ont pas tous fait l'objet d'une nouvelle validation médicale dans cet audit.

| Section | Élément | Code actuel | Affichage | Référence Ti' Pierre | Statut | Action proposée |
|---|---|---|---|---|---|---|
| ACR p.1 | Ventilation | PDF statique | FiO2=1 ;VT6–8ml/kg ;FR10–20/min ;Pmax25cmH2O | Pas de schéma complet | ABSENT DU REFERENTIEL | Valider protocole de réanimation par âge, différent de FR physiologique. |
| ACR p.1 | Compressions/voie | PDF statique | 100–120/min ;≥1/3 thorax(5cm) ;relai2min ;VVP<1min sinonIO | Absent | ABSENT DU REFERENTIEL | Validation actuelle ERC/pédiatrie nécessaire. |
| ACR p.1–2 | Adrénaline | PDF statique | 10µg/kg toutes4min ;1mg/10ml ;1ml/10kg | p.13 10–30µg/kg IV ;dilution10µg/ml<10kg et100>10 | A VERIFIER MEDICALEMENT | Coefficient bas concordant ; dilution indépendante du poids différente du PDF local. |
| ACR p.2 | Abaque adrénaline | PDF statique100µg/ml | W=5/10/15/20/30/40/50 →0,5/1/1,5/2/3/4/5ml | p.13 dose10µg/kg incluse | CONFORME | Tous calculs de volume exacts pour cette concentration. |
| ACR p.1–2 | Défibrillation et cycles | PDF statique | 4J/kg ;cycles2min ;adrénaline/amiodarone après3e choc ;adrénaline à cycles alternés ;après5e choc réfractaire8J/kg max360J | p.13 2 puis4J/kg | INCOHERENT | Source actualisée commune aux écrans ; ne pas mélanger algorithmes. |
| ACR p.1–2 | Électrodes/DAE | PDF statique | <10kg pédiatriques ;>10adultes ;DAE>1an ;<25kg atténuateur50–75J ;sans atténuateur dernier recours | Absent | ABSENT DU REFERENTIEL | Valider frontières dont exactement10kg. |
| ACR p.1 | Amiodarone | PDF statique | Après3e choc5mg/kg IVD max300mg | p.13 5mg/kg IVL20min | A VERIFIER MEDICALEMENT | Voie/vitesse dépend du contexte ACR ; ne pas qualifier automatiquement l'écart d'erreur. |
| ACR p.1–2 | Lidocaïne | PDF statique | Alternative1mg/kg IVD max100mg ;SE20–50µg/kg/min | p.13 1mg/kg ;pas débit/max | A VERIFIER MEDICALEMENT | Valider plafond/perfusion et indication. |
| ACR p.1 | Magnésium | PDF statique | Torsades25–50mg/kg IVD max2g | p.13 30–60mg/kg dans asthme grave | ABSENT DU REFERENTIEL | Autre indication : asthme ne valide pas torsades. |
| ACR p.1 | Hypovolémie | PDF statique | Cristalloïdes20ml/kg | p.7 10–20ml/kg | CONFORME | Borne haute dans contexte ACR. |
| ACR p.1 | HyperK calcium | PDF statique | Gluconate50mg/kg=0,5ml/kg max2g | p.14 0,5ml/kg à10% | A VERIFIER MEDICALEMENT | Égalité implique100mg/ml ; concentration/masse de sel à expliciter. |
| ACR p.1 | HyperK bicarbonate | PDF statique | NaHCO3 4,2%1–2ml/kg | Non indiqué dans ce passage local | ABSENT DU REFERENTIEL | Valider indication/dose et concentration. |
| ANA p.1 | Grade affiché | PDF statique | Titre >GRADEII mais traitement inclut grade2 | Pas d'algorithme | INCOHERENT | Clarifier portée du titre lors révision du document. |
| ANA p.1 | Remplissage | PDF statique | Cristalloïdes10–30ml/kg ±HEA10ml/kg | p.7 10–20 ;pas HEA<6mois | A VERIFIER MEDICALEMENT | Indication anaphylaxie et actualité des colloïdes à arbitrer ; restriction d'âge absente. |
| ANA p.1 | Adrénaline bolus | PDF statique | Grade2 1µg/kg ;3 5 ;4 10 IV | p.13 doseACR, pas tableau anaphylaxie | ABSENT DU REFERENTIEL | Valider algorithme contextuel ; ne pas utiliser dose générique H. |
| ANA p.2 | Abaque grade2/3 | PDF statique10µg/ml | Grade2 pourW5/10/15/20/30/40/50 :0,5/1/1,5/2/3/4/5ml ;grade3 W5/10/15/20 :2,5/5/7,5/10ml | Tableau absent | ABSENT DU REFERENTIEL | Volumes arithmétiquement exacts ; cases restantes non renseignées, pas zéro. |
| ANA p.2 | Abaque grade3/4 | PDF statique100µg/ml | Grade3 W30/40/50 :1,5/2/2,5ml ;grade4 W5/10/15/20/30/40/50 :0,5/1/1,5/2/3/4/5ml | Tableau absent | ABSENT DU REFERENTIEL | Volumes exacts pour doses imprimées. |
| ANA p.1–2 | Adrénaline/noradrénaline IVSE | PDF statique1mg/50ml | 0,1µg/kg/min ;W5/10/15/20/30 →1,6/3,3/5/6,6/10ml/h | p.13 plages compatibles, autre préparation | ERREUR PROBABLE DE CALCUL | Incohérence arithmétique certaine :débits théoriques1,5/3/4,5/6/9 ; faire corriger source après validation. |
| ANA p.1 | Bleu de méthylène | PDF statique | 1–3mg/kg IVL si inefficacité adrénaline | Absent | ABSENT DU REFERENTIEL | Validation spécialisée. |
| ANA p.1 | Salbutamol inhalé | PDF statique | 50µg/kg max10bouffées | p.13 nébulisation, pas cet inhalateur | A VERIFIER MEDICALEMENT | Dose par bouffée non spécifiée ; voie/formulation à préciser. |
| ANA p.1 | Salbutamol IV | PDF statique | 5µg/kg sur10min puis1µg/kg/min au départ | Absent | ABSENT DU REFERENTIEL | Source pédiatrique et surveillance ; contexte hypotension privilégie adrénaline dans fiche. |
| ANA p.1 | Suivi | PDF statique | PrélèvementsT0,H2,H24 ;surveillance≥24h ;tests4–6semaines | Absent | ABSENT DU REFERENTIEL | Valider parcours actuel ; sugammadex évoqué sans dose, aucun calcul caché. |
| HM p.1 | Ventilation/refroidissement | PDF statique | FiO2 100% ;gaz frais2–3×ventilation minute ;refroidir jusqu'à38°C | Pas de schéma complet | ABSENT DU REFERENTIEL | Validation protocole HM. |
| HM p.1 | Dantrolène charge/répétition | PDF statique | 2,5mg/kg IVD ;flacon20mg/60ml ;1mg/kg toutes10min jusqu'à10mg/kg | p.14 2,5–3 initial,compléments1,max10 | CONFORME | Coefficients concordants ; préparer selon présentation exacte. |
| HM p.2 | Abaque charge, mg | PDF statique | W5/10/15/20/30/40/50 →12,5/25/37,5/50/75/100/125mg | p.14 plage inclut2,5 | CONFORME | Multiplications exactes. |
| HM p.2 | Abaque charge, volumes/flacons | PDF statique20mg/60ml | flacons0,6/1,25/1,9/2,5/3,7/5/6,25 ;ml40/75/110/150/220/300/375 | Pas d'abaque | ECART MINEUR | Volumes exacts37,5/75/112,5/150/225/300/375 ; arrondis variables −2,2% à+6,7% à expliciter. |
| HM p.2 | Abaque complément | PDF statique | mêmes W :mg5/10/15/20/30/40/50 ;flacons0,25/0,5/0,75/1/1,5/2/2,5 ;ml15/30/45/60/90/120/150 | p.14 complément1mg/kg | CONFORME | Arithmétique exacte. |
| HM p.1 | Entretien/surveillance | PDF statique | Dantrolène1mg/kg/4h tant que signes ;réanimation≥24h | Non détaillé localement | ABSENT DU REFERENTIEL | Validation externe du suivi. |
| HM p.1 | HyperK insuline/glucose | PDF statique | 0,1UI/kg +10ml/kg G10% sur15min (=1g/kg glucose) | p.14 insuline0,1+glucose0,5g/kg sur30min | A VERIFIER MEDICALEMENT | Écart de quantité/durée ; contexte HM distinct, ne pas conclure erreur automatiquement. |
| HM p.1 | HyperK calcium | PDF statique | 0,5ml/kg max2g si trouble rythme | p.14 0,5ml/kg à10% | A VERIFIER MEDICALEMENT | Concentration non écrite sur cette fiche, nécessaire pour plafond en g. |
| HM p.1 | Acidose | PDF statique | pH<7,2 :1mEq/kg=2ml/kg bicarbonate4,2% | Absent | ABSENT DU REFERENTIEL | Conversion exacte ; indication externe à valider. |
| AL p.1 | Maximum lidocaïne | PDF statique | 6mg/kg | p.10 max7,5 | INCOHERENT | Harmoniser selon voie/adrénaline/âge, non spécifiés. |
| AL p.1 | Maximum bupivacaïne | PDF statique | 2mg/kg | p.10 max3 ;A calcule2,5/6h | INCOHERENT | Arbitrage prioritaire entre trois repères. |
| AL p.1 | Maximum ropivacaïne | PDF statique | 3mg/kg | p.10 max3,5 | INCOHERENT | Harmoniser contexte et définition du maximum. |
| AL p.1 | Maximum mépivacaïne/lévobupivacaïne | PDF statique | 5mg/kg et3mg/kg | Absents | ABSENT DU REFERENTIEL | Source externe ; produits présents uniquement dans cette fiche. |
| AL p.1 | Délai/surveillance | PDF statique | Toxicité retardée jusqu'à40min ;surveillance≥6h | Non détaillé | ABSENT DU REFERENTIEL | Validation actuelle et contexte. |
| AL p.1 | Réanimation spécifique | PDF statique | FiO2=1 ;adrénaline début1–5µg/kg ;amiodarone5mg/kgIVL ;pas lidocaïne | p.13 générique10–30adr,5amio,1lido | A VERIFIER MEDICALEMENT | Spécificité toxicitéAL ; ne pas appliquer mécaniquement schéma générique ACR. |
| AL p.2 | Abaque adrénaline | PDF statique10µg/ml | 1µg/kg :0,1Wml ;5µg/kg :0,5Wml seulement W5/10/15/20 renseignés | Tableau absent | ABSENT DU REFERENTIEL | Calculs exacts ; cases vides>20kg ne valent pas zéro. |
| AL p.1 | Convulsions midazolam | PDF statique | 0,2mg/kg IV | p.3 autres voies de prémédication, pas cette dose/indication | ABSENT DU REFERENTIEL | Validation contextuelle externe. |
| AL p.1 | Intralipide20% | PDF statique | 1,5ml/kg1min puis0,25ml/kg/min ;répéter1–2fois toutes5min ;augmenter0,5 ;max10ml/kg30min | p.10 mêmes coefficients mais bolus toutes3min | A VERIFIER MEDICALEMENT | Harmoniser intervalle3/5min et protocole actuel. |
| AL p.1 | Médialipide20% | PDF statique | 6–9ml/kg bolus répétable5min | Absent | ABSENT DU REFERENTIEL | Valider produit/protocole, ne pas substituer au schéma Intralipide. |
| IOT p.1 | Limite/essais | PDF statique | Enfant<8ans ;échec2laryngoscopies ;2essais/senior ;DSG3max ;fibroscopie viaDSG1essai | Pas d'algorithme | ABSENT DU REFERENTIEL | Source actuelle ; fiche accessible à tout âge saisi. |
| IOT p.1 | Ventilation | PDF statique | FiO2=1 ;PEP5cmH2O ;pression masque<25 ;billot<10kg | Absent | ABSENT DU REFERENTIEL | Validation algorithme et matériel. |
| LAR p.1 | Ventilation | PDF statique | FiO2=1 ;pression<15cmH2O si<1an, <30 si>1an | Absent | ABSENT DU REFERENTIEL | Exactement1an non explicite ; contexte laryngospasme. |
| LAR p.1 | Propofol | PDF statique | Approfondissement1–2mg/kg ;IV laryngospasme complet1–2 | Pas cette indication/dose | ABSENT DU REFERENTIEL | Ne valide pas induction2–5 du calculateur. |
| LAR p.1 | Succinylcholine/atropine | PDF statique | IV ouIO sux1–2mg/kg ±atropine0,02mg/kg ;IM sux4 ±atropine0,02 | p.14 sux2nouveau-né/nourrisson,1,5enfant ;p.13 atrop20µg/kg | A VERIFIER MEDICALEMENT | Doses/routes spécifiques ;4mg/kgIM ne doit pas être lu comme doseIV. |
| LAR p.1 | Fréquence événement | PDF statique | 90% induction/réveil | Absente | ABSENT DU REFERENTIEL | Statistique informative à sourcer, pas seuil de traitement. |
| NN p.1 | Température/O2 initial | PDF statique | Pièce26°C ;table38 ;cible36,5–37,5 ;FiO2 initial21% | p.2 salle24°C<2ans, contexte anesthésie | A VERIFIER MEDICALEMENT | Contextes différents ; ne pas fusionner les cibles. |
| NN p.1 | Aspiration | PDF statique | 100–150cmH2O ;sondes6–14Ch ;bouche10Ch,nez8Ch | p.4 Fr=2D | A VERIFIER MEDICALEMENT | Contexte naissance et réglage pression distincts. |
| NN p.1 | IOT/masque laryngé | PDF statique | Sondes2,5/3/3,5 ;ML1 ;sonde2,5 à2kg,3,5>3kg ;repère nez9–10,bouche8–9 sans unité imprimée | p.4 nouveau-néD2,5–3 ;oral3D,nasal+2 | A VERIFIER MEDICALEMENT | Source néonatale, unité des repères et bornes à préciser. |
| NN p.1 | Ventilation/FC | PDF statique | 3insufflations2–3s puis0,5s ;40/min ;PEP5 ;augmenterO2 siFC<100 ;évaluation30s | p.13 nouveau-néFC<80inefficace,<60ACR | A VERIFIER MEDICALEMENT | Algorithme salle de naissance distinct ; source actuelle. |
| NN p.1–2 | Compressions | PDF statique | FC<60 :3compressions/1ventilation en2s ;90CT+30vent/min ;profondeur1/3thorax,1/3inférieur sternum | p.13 FC<60 ACR, pas rythme | A VERIFIER MEDICALEMENT | Arithmétique3:1 exacte ; validation néonatale. |
| NN p.1 | Adrénaline IV/IT | PDF statique100µg/ml | IV0,1ml/kg toutes3min=10µg/kg ;IT1ml/kg max3ml=100µg/kg max300µg | p.13 IV10–30µg/kg ;IT absent | A VERIFIER MEDICALEMENT | Distinguer strictement voies et concentrations. |
| NN p.1 | Constantes vers3kg | PDF statique | FC120–140 ;PAS70–80 ;PAM=SA ;FR30–60 ;Hb13–17 | p.6/8 FC140–180,PA60/35,Hb17,FR30–60 | A VERIFIER MEDICALEMENT | Naissance/adaptation vs repères anesthésiques ; pas substitution automatique. |
| NN p.1 | Saturation | PDF statique | À2/3/4/5/10min :60/70/80/85/90% | Absente | ABSENT DU REFERENTIEL | Valider cibles selon référentiel naissance actuel. |
| NN p.1 | Hypovolémie/anémie | PDF statique | NaCl0,9%10ml/kg ;Hbcap<11 :CGR O−15ml/kg10min | p.7 bolus10–20 ;p.8 CGR15 standard,seuil10 nouveau-né | A VERIFIER MEDICALEMENT | Contexte naissance, seuil/durée propres. |
| NN p.1 | Hypoglycémie | PDF statique | <0,3g/dL :G10%2ml/kgIV ;contrôle30min | p.14 seuil0,5g/L,G10%2–4ml/kg | ERREUR PROBABLE D'UNITE | 0,3g/dL=3g/L ; vérifier unité et seuil exact avant correction du PDF. |
| NN p.2 | Cathéter ombilical | PDF statique | Cordon sectionné2cm ;KT inséré5cm maximum | Absent | ABSENT DU REFERENTIEL | Validation procédure et position, pas formule patient. |

## Couverture du Ti' Pierre : éléments non implémentés

Cette liste évite de confondre **absent de l'application** et **ABSENT DU REFERENTIEL**. Elle ne propose pas d'ajouter automatiquement des traitements. Les chiffres ci-dessous décrivent le document fourni, y compris ses incertitudes ; ils ne constituent pas des recommandations supplémentaires.

| Domaine/page | Contenu du document non calculé ou non repris dans le parcours concerné |
|---|---|
| Préopératoire p.2–3 | Restrictions ambulatoires <6mois/60SAPC ; réchauffement salle24°C<2ans,21°C au-delà ; jeûne solides6h, lait artificiel4h<6mois sinon6h, lait maternel3h<6mois sinon6h, liquides clairs2h à10ml/kg max200ml. Aucun calculateur préopératoire. |
| Prémédication p.3 | Midazolam PO0,5mg/kg ouIR0,3–0,5, max10mg, pas<6mois ; atropine20µg/kgIR chez nouveau-né ; hydroxyzine1–2mg/kg (limites2mg/kg et100mg/j), clonidine4µg/kgPO/IR. Délais30min pour midazolam/atropine,1h pour hydroxyzine/clonidine ; EMLA1h30 retiré15min avant, demi-patch0,5g H−1 chez ex-prématuré. Non implémentés. |
| Matériel p.4 | SNG2D+2 ouW+7, voie orale<2–3mois ; repère nasal=oral+2cm. Tableau IOT par âge : nouveau-né2,5–3 ;<1an3,5–4 ;1–2ans4–4,5 ;2–5ans4,5–5 ;5–12ans5–6,5 ;>12ans6,5–7. Non repris comme tableau complet, distinct des calculs pondéraux actuels. |
| Vasculaire p.5 | Longueurs VVC : nouveau-né–3mois6cm/3Fr,3mois–1an8cm/3Fr,1–6ans11cm/4Fr,>6ans13–16cm/>5Fr. PICC<15kg40cm/3Fr,>15kg60cm/4Fr, calibre≤1/3veine ;3Fr≈1mm, ne pas dépasser4Fr. Restriction fémorale<10kg non affichée. |
| Hémodynamique p.6 | Objectif PAS>90+2Y ; risque cérébral<6mois PAM<33 ou baisse≥20%, après6mois PAM<43 ou baisse≥40%. Non affichés, ne pas confondre avec définition d'hypotension. Poids indicatifs du tableau par âge≤3,<10,10–12,12–20,20–40,>40kg non utilisés pour les constantes. |
| Fluides p.7 | Recette B66 (RL250ml+ampouleG30), PSE nouveau-né/nourrisson ; pasHEA<6mois ; albumine20%1g/kg et4%10ml/kg. Pas de calcul dans l'application. Berry écart intentionnel déjà signalé. |
| Transfusion/fer p.8–9 | CGR4ml/kg pour augmenterHb1g/dl ou15ml/kg standard ; groupage mère/enfant<6mois ; Venofer3–5mg/kg J1/J3/J5 ; Fumafer6–10mg/kg/j (poudre0,3cuillère-mesure/kg/j si<30kg, comprimés66mg2–3/j selon âge/poids) ; Tardyferon>6ans5mg/kg/j (1cp6–10ans,1–2cp>10ans). Non calculés. Numération plaquettes0,5–0,7×10^11/7kg non reprise ; volumes15–20ml/kg déjà couverts. |
| Damage control p.9 | Objectifs PAM≤2ans :>55 avec neurotrauma,>45 sans ;≥2ans :>65 avec,>55 sans. Chevauchement à2ans dans le PDF, non repris dans l'application. |
| ALR p.10 | Ropivacaïne bolus0,2%>6mois,0,1%<6mois,0,05%<1mois ; entretien0,1%<2ans/0,2%>2ans. Volumes blocs : fémoral/BSP0,2–0,3ml/kg ;BIS/infraclaviculaire/supraclaviculaire/axillaire0,3–0,5 ;TAP/ilio0,2–0,4par côté ;paraombilical0,1–0,2par côté ;pénien/pudendal0,1par côté max5ml, pas adrénaline pénien. Cathéter0,1ml/kg/h +bolus0,1ml/kg, verrou30min. Ropivacaïne continue max0,4mg/kg/h>6mois,0,3<6mois,0,2<1mois. Non implémentés ; ne justifient pas /6h. |
| Antalgie p.11 | Tramadol1–2mg/kg3–4/j, max8mg/kg/j ou400mg/j,≥3ans ;1goutte2,5mg ; nalbuphine IVSE1mg/kg/j etIR0,3mg/kg non calculées. PCA/NCA morphine Wmg/50ml=20µg/kg/ml ;bolus1ml, verrou7–8min ;continu20µg/kg/h non en première intention ;max4h300µg/kg. Pas de module PCA. |
| Divers p.12 | Scores VPOP/POVOC non calculés ; oméprazole1mg/kg/j ;trimébutine1dose/kg/8h ;gabapentine30–40mg/kg/j en2prises≥3ans. Non implémentés. |
| Urgences respiratoires p.13 | Caféine citrate20mg/kg IV30min puis àH24 5mg/kg/j ;salbutamol nébulisé1,25mg<10kg,2,5mg10–30kg,5mg>30 ;budésonide0,5mg<10kg,1mg>10 deux fois/j ;adrénaline nébulisée0,5mg/kg max5mg ;magnésium30–60mg/kg=0,2–0,4ml/kg pour asthme grave. Aucun calculateur de ces schémas ; les fiches anaphylaxie/laryngospasme/ACR utilisent d'autres voies ou indications. |
| Neurologie p.14 | Desmopressine0,2–0,4µg/j de0–2ans,0,4–1µg/j au-delà en2prises ;non implémentée. Les autres lignes neurologiques calculées sont auditées plus haut. |
| Métabolique p.14 | Hypoglycémie0,5g/L :G10%2–4ml/kg puis0,25–0,75mg/kg/h (unité suspecte, signalée). HyperK :insuline0,1UI/kg+glucose0,5g/kg30min ;gluconateCa10%0,5ml/kg ;furosémide1–2mg/kg ;salbutamol nébulisé0,2mg/kg/30min. Aucun calculateur métabolique ; certains éléments apparaissent dans fiches ACR/HM/NN avec différences décrites. |
| Réversion p.14 | Sugammadex à partir de2ans en décurarisation de routine évoqué sans dose ;pas de dose calculée. Dantrolène est présent dans la fiche HM, analysée ci-dessus. |

## Contrôles réalisés et limites

Un script exploratoire est conservé hors dépôt : [coherence_audit.dart](C:/Users/Thomas/.codex/visualizations/2026/09/26/01a0ddea-327f-7ec3-ba79-31ecf97eb579/audit/coherence_audit.dart). Il extrait les multiplicateurs simples du code actuel, importe les fonctions françaises existantes, et ne modifie aucune donnée.

- 13 couples min/max extraits de H : ordre correct pour poids positif. Fibrinogène, phényléphrine, trois pertes chirurgicales et monotonie4-2-1 contrôlés sur1–150kg.
- Conversion années/mois et seuil PAS contrôlés sur0–18ans. Les seuils non disponibles restent null ; pas de mois directement multipliés comme des années.
- Contre-exemples de plafonds :2 500mg amox à50kg ;2 400mg céfoxitine à60kg ;1 000mg clindamycine à100kg ;500mg ibuprofène à50kg ;1,5mg clonazépam à30kg.
- Formatage Dart réel vérifié pour rocuronium1/2/3/5kg et parseur sur décimales/texte/vide/négatif.
- Dilutions noradrénaline/dobutamine et tableau anaphylaxie recalculés dimensionnellement. Les abaques dantrolène ont été comparés au rapport20mg/60ml.
- La comparaison de l'aide au calcul, les unités, le jour/prise, les indications et les branches ont aussi été relus manuellement. Le script ne prétend pas reconnaître automatiquement toutes les erreurs sémantiques ni valider une posologie.
- `git diff --check` : réussi, sortie0 ; contrôle séparé du nouveau rapport également effectué (fichier non suivi).
- `flutter test` : **81 tests réussis**, sortie0. Ces tests logiciels ne prouvent pas la validité médicale des valeurs.
- `flutter analyze` : **un avertissement préexistant**, `unused_element_parameter` pour `backgroundColor`, H499:10 ; sortie1. Aucune correction faite dans cette passe.

Les correspondances au PDF sont explicites, mais les valeurs non sourcées et les décisions cliniques restent ouvertes. Les quatre RCP cités ont fait l'objet d'une vérification ciblée ; aucune homologation exhaustive des traitements par une source externe actuelle n'est revendiquée. Les fiches contiennent aussi des conduites non chiffrées dont la révision clinique n'est pas remplacée par cet audit des valeurs.

## Annexe — formules et affichages exacts du code audité

Extraits locaux avec numéros de ligne : ils permettent de vérifier les chaînes, conditions, arrondis et formules sans les réinterpréter. Les espaces de fin de ligne ont été retirés dans les extraits. Les commentaires inclus sont des preuves de l’état du code, pas une validation de leur contenu clinique. En particulier, le commentaire Exacyl ne résout pas l’ambiguïté du PDF signalée plus haut.

<details>
<summary>lib/homepage.dart</summary>

```dart
// Extrait lignes 127–350
127:   Map<String, String> obtenirKtarteriel(int poids) {
128:     if (poids < 1) {
129:       return {'kt arteriel': '1 Fr (24Ga)'};
130:     } else if (poids < 10) {
131:       return {'kt arteriel': '3 Fr (24Ga)'};
132:     } else if (poids < 20) {
133:       return {'kt arteriel': '3 Fr (20Ga)'};
134:     } else if (poids < 30) {
135:       return {'kt arteriel': '4 Fr (20Ga ou 18Ga)'};
136:     } else {
137:       return {'kt arteriel': '5 Fr (18Ga)'};
138:     }
139:   }
140:
141:   Map<String, String> obtenirVvc(int poids) {
142:     if (poids < 2) {
143:       return {'vvc': '2 - 3 Fr'};
144:     } else if (poids < 4) {
145:       return {'vvc': '3 - 4 Fr '};
146:     } else if (poids < 10) {
147:       return {'vvc': '4 - 5 Fr'};
148:     } else if (poids < 20) {
149:       return {'vvc': '5 - 6 Fr'};
150:     } else if (poids < 40) {
151:       return {'vvc': '6 - 7 Fr'};
152:     } else {
153:       return {'vvc': '7 - 8.5 Fr'};
154:     }
155:   }
156:
157:   Map<String, String> obtenirBallon(int poids) {
158:     if (poids <= 10) {
159:       return {'ballon': '0,5 litre'};
160:     } else if (poids <= 20) {
161:       return {'ballon': '1 litre'};
162:     } else if (poids <= 30) {
163:       return {'ballon': '2 litres'};
164:     } else {
165:       return {'ballon': 'adulte'};
166:     }
167:   }
168:
169:   Map<String, String> obtenirtauxhb(int ageEnMois) {
170:     if (ageEnMois < 1) {
171:       return {'hb': '17 g/dl'};
172:     } else if (ageEnMois < 2) {
173:       return {'hb': '14 g/dl'};
174:     } else if (ageEnMois < 3) {
175:       return {'hb': '10 - 11 g/dl (anemie physiologique)'};
176:     } else if (ageEnMois < 24) {
177:       return {'hb': '12 g/dl'};
178:     } else if (ageEnMois < 72) {
179:       return {'hb': '13.5 g/dl'};
180:     } else {
181:       return {'hb': '14 g/dl'};
182:     }
183:   }
184:
185:   Map<String, String> obtenirsad(int ageEnMois) {
186:     if (ageEnMois < 1) {
187:       return {'sad': '5 - 6 Fr'};
188:     } else if (ageEnMois < 2) {
189:       return {'sad': '6 - 8 Fr'};
190:     } else if (ageEnMois < 12) {
191:       return {'sad': '6 - 8 Fr'};
192:     } else if (ageEnMois < 36) {
193:       return {'sad': '8 Fr'};
194:     } else if (ageEnMois < 72) {
195:       return {'sad': '8 - 10 Fr'};
196:     } else if (ageEnMois < 120) {
197:       return {'sad': '10 - 12 Fr'};
198:     } else if (ageEnMois < 192) {
199:       return {'sad': '12 - 14 Fr'};
200:     } else {
201:       return {'sad': '14 - 16 Fr'};
202:     }
203:   }
204:
205:   Map<String, String> obtenirtaillesonde(int poids) {
206:     if (poids <= 4) {
207:       return {'taillesonde': '2.5 a 3.0'};
208:     } else if (poids <= 9) {
209:       return {'taillesonde': '3.5'};
210:     } else if (poids <= 14) {
211:       return {'taillesonde': '4.0'};
212:     } else if (poids <= 19) {
213:       return {'taillesonde': '4.5'};
214:     } else if (poids <= 24) {
215:       return {'taillesonde': '5.0'};
216:     } else if (poids <= 29) {
217:       return {'taillesonde': '5.5'};
218:     } else if (poids <= 34) {
219:       return {'taillesonde': '6.0'};
220:     } else if (poids <= 39) {
221:       return {'taillesonde': '6.5'};
222:     } else {
223:       return {'taillesonde': '7.0'};
224:     }
225:   }
226:
227:   Map<String, String> obtenirTailleLame(int poids) {
228:     if (poids <= 5) {
229:       return {'taillelame': '0 - 1'};
230:     } else if (poids <= 10) {
231:       return {'taillelame': '1'};
232:     } else if (poids <= 12) {
233:       return {'taillelame': '1 - 2'};
234:     } else if (poids <= 34) {
235:       return {'taillelame': '2'};
236:     } else {
237:       return {'taillelame': '3'};
238:     }
239:   }
240:
241:   Map<String, String> obtenirTailleAspi(int poids) {
242:     if (poids < 5) {
243:       return {'tailleaspi': '6 - 8'};
244:     } else if (poids <= 10) {
245:       return {'tailleaspi': '8'};
246:     } else if (poids <= 15) {
247:       return {'tailleaspi': '10'};
248:     } else if (poids <= 20) {
249:       return {'tailleaspi': '12'};
250:     } else if (poids <= 35) {
251:       return {'tailleaspi': '14'};
252:     } else {
253:       return {'tailleaspi': '16'};
254:     }
255:   }
256:
257:   void calculerDosesEtSonde() {
258:     final int age = int.tryParse(ageController.text) ?? 0;
259:     final int ageEnMois = convertirAgeEnMois(age, enMois: isAgeInMonths);
260:     final int poids = int.tryParse(poidsController.text) ?? 0;
261:
262:     setState(() {
263:       hypotensionsup1 = calculerSeuilHypotension(ageEnMois);
264:       dosePropofolmini = poids * 2;
265:       dosePropofolmaxi = poids * 5;
266:       doseEtomidate = poids * 0.2;
267:       doseKetaminemini = poids * 2;
268:       doseKetaminemaxi = poids * 4;
269:       doseSufentamini = poids * 0.2;
270:       doseSufentamaxi = poids * 0.4;
271:       doseAlfentanylmini = poids * 20;
272:       doseAlfentanylmaxi = poids * 40;
273:       doseRemifentanylmini = poids * 0.2;
274:       doseRemifentanylmaxi = poids * 0.5;
275:       doseFentanylmini = poids * 20;
276:       doseFentanylmaxi = poids * 50;
277:       doseCisatracrium = poids * 0.2;
278:       doseParacetamol = poids * 15;
279:       doseProfenid = poids;
280:       doseMorphine = poids * 0.1;
281:       doseNalbuphine = calculerNalbuphineMg(poids, ageEnMois);
282:       dosePropofolEntretien = poids * 10.0;
283:       doseAdrenaline = poids * 0.01;
284:       doseAtropine = poids * 0.02;
285:       poidstext = poids * 1;
286:       agemoistext = ageEnMois * 1;
287:       remplissagevasc = poids * 20;
288:       doseDexametasone = poids * 0.15;
289:       doseNarcan = poids * 10;
290:       doseketaNMDA = poids * 0.2;
291:       doseExacyl = calculerExacyl(poids).chargeMg;
292:       doseLidocaine = poids * 5;
293:       doseBupivacaine = poids * 2.5;
294:       dosePrilocaine = poids * 5;
295:       doseRopivacaine = poids * 3;
296:       doseCefazoline = poids * 30;
297:       doseAmox = poids * 50;
298:       doseClindamycine = poids * 10;
299:       doseGentamycine = poids * 6;
300:       doseCefoxitine = poids * 40;
301:       doseMetronidazole = poids * 15;
302:       dosecordarone = poids * 5;
303:       doseVancomycinemini = poids * 20;
304:       doseVancomycinemaxi = poids * 30;
305:       doseminPFC = poids * 10;
306:       dosemaxPFC = poids * 30;
307:       doseminPqt = poids * 15;
308:       dosemaxPqt = poids * 20;
309:       doseOndansetron = poids * 0.1;
310:       doseGluconateCamin = poids * 7.5;
311:       doseGluconateCamax = poids * 15;
312:       final fibrinogene = calculerFibrinogeneGrammes(poids);
313:       doseminFibri = fibrinogene.minimum;
314:       dosemaxFibri = fibrinogene.maximum;
315:       doseOramorph = poids * 0.2;
316:       doseActiskenan = poids * 1;
317:       doseSkenan = poids * 1;
318:       doseAdvil = poids * 10;
319:       doseSpasfon = poids;
320:       doseDroleptan = poids * 20;
321:       doseManitol = poids * 0.5;
322:       doseSshmin = poids * 6.5;
323:       doseSshmax = poids * 10;
324:       doseValium = poids * 0.5;
325:       doseRivotril = poids * 0.05;
326:       doseCelocurinemaxi = poids * 2;
327:       doseCelocurinemini = poids;
328:       final phenylephrine = calculerPhenylephrineMicrogrammes(poids);
329:       doseneomin = phenylephrine.minimum;
330:       doseneomax = phenylephrine.maximum;
331:
332:       doseAtracrium = poids * 0.5;
333:       doseRocuroniummini = poids * 0.6;
334:       doseRocuroniummaxi = poids * 1.2;
335:       apportLiquidien = calculerApportLiquidien(poids);
336:       constantesPhysiologiques = obtenirConstantesPhysiologiques(ageEnMois);
337:       vtmin = poids * 6;
338:       vtmax = poids * 8;
339:       repereiot = ageEnMois / 12 / 2 + 12;
340:       taillelame = obtenirTailleLame(poids);
341:       tailleaspi = obtenirTailleAspi(poids);
342:       circuit = obtenirCircuit(poids);
343:       ballon = obtenirBallon(poids);
344:       sad = obtenirsad(ageEnMois);
345:       taillesonde = obtenirtaillesonde(poids);
346:       tailleguedel = obtenirTailleguedel(ageEnMois);
347:       hb = obtenirtauxhb(ageEnMois);
348:       vvc = obtenirVvc(poids);
349:       ktarteriel = obtenirKtarteriel(poids);
350:     });
// Extrait lignes 876–922
876:                     mainAxisSize: MainAxisSize.min,
877:                     children: [
878:                       Row(
879:                         crossAxisAlignment: CrossAxisAlignment.start,
880:                         children: [
881:                           Expanded(
882:                             child: Text(
883:                               'FC: ${constantesPhysiologiques!['FC']}',
884:                               textAlign: TextAlign.center,
885:                               style: const TextStyle(
886:                                 color: Color(0xFF4CAF50),
887:                                 fontSize: 17,
888:                                 fontWeight: FontWeight.bold,
889:                               ),
890:                             ),
891:                           ),
892:                           Expanded(
893:                             child: Text(
894:                               'FR: ${constantesPhysiologiques!['FR']}',
895:                               textAlign: TextAlign.center,
896:                               style: const TextStyle(
897:                                 color: Colors.white,
898:                                 fontSize: 17,
899:                                 fontWeight: FontWeight.bold,
900:                               ),
901:                             ),
902:                           ),
903:                         ],
904:                       ),
905:                       const SizedBox(height: 12),
906:                       Text(
907:                         'PAS - PAD: ${constantesPhysiologiques!['PAS']}',
908:                         style: const TextStyle(
909:                           color: Colors.red,
910:                           fontSize: 17,
911:                           fontWeight: FontWeight.bold,
912:                         ),
913:                       ),
914:                       const SizedBox(height: 12),
915:                       if (constantesPhysiologiques!.containsKey('Hypotension'))
916:                         Text(
917:                           'Hypotension: ${constantesPhysiologiques!['Hypotension']}',
918:                           style: const TextStyle(
919:                             color: Color(0xFFE040FB),
920:                             fontSize: 12,
921:                             fontWeight: FontWeight.bold,
922:                           ),
// Extrait lignes 936–951
936:               icon: Icons.air_outlined,
937:               children: [
938:                 _DoseRow(name: 'Circuit', dose: '${circuit!['circuit']}'),
939:                 _DoseRow(name: 'Ballon', dose: '${ballon!['ballon']}'),
940:                 _DoseRow(name: 'Taille Sonde IOT', dose: '${taillesonde!['taillesonde']}'),
941:                 _DoseRow(name: "Taille Sonde d'aspiration", dose: '${tailleaspi!['tailleaspi']}'),
942:                 if (taillelame != null)
943:                   _DoseRow(name: 'Taille Lame', dose: '${taillelame!['taillelame']}'),
944:                 _DoseRow(name: 'Taille Guedel', dose: '${tailleguedel!['tailleguedel']}'),
945:                 if (repereiot != null)
946:                   _DoseRow(name: 'Repere IOT', dose: '${repereiot!.toStringAsFixed(0)} cm'),
947:                 if (vtmin != null && vtmax != null) ...[
948:                   _DoseRow(name: 'Volume courant', dose: '$vtmin - $vtmax ml'),
949:                   _DoseRow(name: 'Frequence Respiratoire', dose: '${constantesPhysiologiques!['FR']}'),
950:                 ],
951:               ],
// Extrait lignes 963–980
963:                 child: Text(
964:                   'Doses Induction',
965:                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textDark),
966:                 ),
967:               ),
968:             ),
969:
970:             ResponsiveMasonry(children: [
971:             // Hypnotiques
972:             _MedicalSection(
973:               title: 'Hypnotiques',
974:               borderColor: AppColors.pastelYellow,
975:               icon: Icons.bedtime_outlined,
976:               children: [
977:                 _DoseRow(name: 'Propofol', dose: '$dosePropofolmini - $dosePropofolmaxi mg', hint: '2 a 5 mg/kg'),
978:                 _DoseRow(name: 'Etomidate', dose: '${doseEtomidate!.toStringAsFixed(1)} mg', hint: '0,2 mg/kg'),
979:                 _DoseRow(name: 'Ketamine', dose: '${doseKetaminemini!.toStringAsFixed(0)} - ${doseKetaminemaxi!.toStringAsFixed(0)} mg', hint: '2 mg/kg pour induction IV'),
980:                 _DoseRow(name: 'Ketamine', dose: '${doseketaNMDA!.toStringAsFixed(1)} mg', hint: '0.2 mg/kg (anti NMDA)'),
// Extrait lignes 989–1022
989:               children: [
990:                 _DoseRow(name: 'Sufentanyl', dose: '${doseSufentamini!.toStringAsFixed(1)} - ${doseSufentamaxi!.toStringAsFixed(1)} mcg', hint: '0,2 mcg/kg'),
991:                 _DoseRow(name: 'Alfentanyl', dose: '$doseAlfentanylmini - $doseAlfentanylmaxi mcg', hint: '20 a 40 mcg/kg'),
992:                 _DoseRow(name: 'Remifentanyl', dose: '${doseRemifentanylmini!.toStringAsFixed(1)} - ${doseRemifentanylmaxi!.toStringAsFixed(1)} µg', hint: '0,2 à 0,5 µg/kg'),
993:                 _DoseRow(name: 'Fentanyl', dose: '$doseFentanylmini - $doseFentanylmaxi mcg', hint: '20 a 50 mcg/kg'),
994:               ],
995:             ),
996:
997:             // Curares
998:             _MedicalSection(
999:               title: 'Curares',
1000:               borderColor: AppColors.pastelRed,
1001:               icon: Icons.fitness_center_outlined,
1002:               children: [
1003:                 _DoseRow(name: 'Cisatracrium', dose: '${doseCisatracrium!.toStringAsFixed(1)} mg', hint: '0,15 a 0,2 mg/kg'),
1004:                 if (agemoistext! < 18)
1005:                   _DoseRow(name: 'Celocurine', dose: '$doseCelocurinemaxi mg', hint: '2 mg/kg'),
1006:                 if (agemoistext! >= 18)
1007:                   _DoseRow(name: 'Celocurine', dose: '$doseCelocurinemini mg', hint: '1mg/kg'),
1008:                 _DoseRow(name: 'Atracrium', dose: '${doseAtracrium!.toStringAsFixed(1)} mg', hint: '0,5 mg/kg'),
1009:                 _DoseRow(name: 'Rocuronium', dose: '${doseRocuroniummini!.toStringAsFixed(0)} - ${doseRocuroniummaxi!.toStringAsFixed(0)} mg', hint: '0,6 mg/kg ou 1 a 1.2mg/kg en ISR'),
1010:               ],
1011:             ),
1012:
1013:             // Cardiovasculaire
1014:             _MedicalSection(
1015:               title: 'Cardiovasculaire',
1016:               borderColor: AppColors.pastelPurple,
1017:               icon: Icons.favorite_outline,
1018:               children: [
1019:                 _DoseRow(name: 'Adrenaline', dose: '${doseAdrenaline!.toStringAsFixed(2)} mg'),
1020:                 _DoseRow(name: 'Atropine', dose: '${doseAtropine!.toStringAsFixed(2)} mg'),
1021:                 _DoseRow(name: 'Néosynéphrine / phényléphrine', dose: '${doseneomin!.toStringAsFixed(1)} - ${doseneomax!} µg', hint: 'Bolus : 0,5 à 2 µg/kg ; maximum : 10 µg/kg'),
1022:                 _DoseRow(name: 'Cordarone', dose: '${dosecordarone!} mg IVL sur 20min', hint: '5 mg/kg'),
// Extrait lignes 1031–1033
1031:                           Text('poids en kg x 0,15 = mg de noradre a ramener dans 25 ml', style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
1032:                           Text('1 ml/h = 0,1 mcg/kg/mn', style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
1033:                           Text('Posologie : 0,05 a 2 mcg/kg/mn', style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
// Extrait lignes 1047–1049
1047:                           Text('poids en kg x 15 = mg de dobu a ramener dans 25 ml', style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
1048:                           Text('0,1 ml/h = 1 mcg/kg/mn', style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
1049:                           Text('Posologie : 5 a 20 mcg/kg/mn', style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
// Extrait lignes 1063–1072
1063:                           Text('300 mcg/kg', style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
1064:                           Text('pas diluee si poids > 10 kg, dilution 300 mcg/ml si < 10kg)', style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
1065:                           Text('Peu efficace en dessous de 1 an', style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
1066:                         ],
1067:                       ),
1068:                     ),
1069:                   ],
1070:                 ),
1071:                 const _DoseRow(name: 'Xylocaine', dose: '1 mg/kg'),
1072:                 const _DoseRow(name: 'Defibrillateur', dose: '2J/kg puis 4J/kg si echec'),
// Extrait lignes 1082–1110
1082:                 _DoseRow(name: 'Paracetamol', dose: '${doseParacetamol!.toStringAsFixed(0)} mg', hint: '15 mg/kg'),
1083:                 if (agemoistext! >= 12)
1084:                   _DoseRow(name: 'Profenid', dose: '$doseProfenid mg', hint: '0.5 - 1 mg/kg'),
1085:                 if (agemoistext! >= 3)
1086:                   _DoseRow(name: 'Advil/ibuprofene', dose: '$doseAdvil mg', hint: '10mg/kg/8h max 400mg/prise'),
1087:                 _DoseRow(name: 'Nalbuphine', dose: '${doseNalbuphine!.toStringAsFixed(1)} mg', hint: '${tauxNalbuphineMgKg(agemoistext!).toStringAsFixed(1).replaceAll(".", ",")} mg/kg (${agemoistext! < 6 ? "âge <6 mois" : "âge ≥6 mois"})'),
1088:                 if (agemoistext! >= 180)
1089:                   const _DoseRow(name: 'Acupan', dose: '1 ampoule 4 a 6/jour'),
1090:                 if (agemoistext! >= 6)
1091:                   _DoseRow(name: 'Oramorph', dose: '${doseOramorph!.toStringAsFixed(1)} mg', hint: '0.2 mg/kg toute les 4 a 6h'),
1092:                 if (agemoistext! >= 6)
1093:                   _DoseRow(name: 'Actiskenan', dose: '${doseActiskenan!.toStringAsFixed(0)} mg', hint: '1 mg/kg/j en 6 prises'),
1094:                 if (agemoistext! >= 6)
1095:                   _DoseRow(name: 'Skenan lp', dose: '${doseSkenan!.toStringAsFixed(0)} mg', hint: '1 mg/kg/j en 2 prises'),
1096:                 _DoseRow(
1097:                   name: 'Morphine IV postopératoire — dose de charge',
1098:                   dose: '${doseMorphine!.toStringAsFixed(1)} mg IV lente',
1099:                   hint: '0,1 mg/kg',
1100:                 ),
1101:                 _DoseRow(
1102:                   name: 'Morphine — bolus de titration après la charge',
1103:                   dose: '${poidstext! * 25} à ${poidstext! * 50} µg par bolus',
1104:                   hint: '25 à 50 µg/kg. Réévaluation toutes les 5 minutes selon protocole et réponse clinique.',
1105:                 ),
1106:                 _DoseRow(
1107:                   name: 'Naloxone',
1108:                   dose: "titration de 40mcg jusqu'a ${doseNarcan!.toStringAsFixed(0)} mcg",
1109:                   hint: "Diluer 1 amp de 0.4mg dans 10ml, injecter bolus de 40mcg jusqu'a ${doseNarcan!.toStringAsFixed(0)} mcg. Poursuivre avec ${doseNarcan!.toStringAsFixed(0)}mcg/h soit 10 mcg/kg/h",
1110:                 ),
// Extrait lignes 1120–1151
1120:                 const Text('Pour la fluidothérapie périopératoire pédiatrique : cristalloïde isotoniquement équilibré en première intention.'),
1121:                 const SizedBox(height: 8),
1122:                 const Text('En chirurgie élective avec un jeûne conforme aux recommandations actuelles, la compensation systématique d’un déficit de jeûne n’est généralement pas nécessaire. Adapter les apports à l’état volémique, aux pertes et au contexte clinique.'),
1123:                 const SizedBox(height: 8),
1124:                 const Text('Pertes chirurgicales', style: TextStyle(
1125:                     fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textDark)),
1126:                 const SizedBox(height: 4),
1127:                 const Text('Estimations à adapter au contexte clinique, pas une prescription automatique.',
1128:                     style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
1129:                 for (final chirurgie in Chirurgie.values)
1130:                   _PertesChirurgicalesRow(
1131:                     niveau: '${chirurgie.libelle[0].toUpperCase()}${chirurgie.libelle.substring(1)}',
1132:                     taux: chirurgie.taux,
1133:                     estimation: poidstext != null && poidstext! > 0
1134:                         ? _pertesPourPoids(poidstext!, chirurgie)
1135:                         : null,
1136:                   ),
1137:                 ExpansionTile(
1138:                   expandedAlignment: Alignment.topLeft,
1139:                   title: Text(
1140:                     'Apport Liquidien de base: $apportLiquidien ml/h',
1141:                     style: const TextStyle(fontSize: 14, color: AppColors.textDark),
1142:                   ),
1143:                   children: const [
1144:                     Padding(
1145:                       padding: EdgeInsets.all(8.0),
1146:                       child: Column(
1147:                         crossAxisAlignment: CrossAxisAlignment.start,
1148:                         children: [
1149:                           Text("Apports de base — règle 4-2-1 : 0 à 10 kg : 4 ml/kg/h ; >10 à 20 kg : 40 ml/h + 2 ml/kg/h par kg au-delà de 10 ; >20 kg : 60 ml/h + 1 ml/kg/h par kg au-delà de 20.", style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
1150:                           SizedBox(height: 8),
1151:                           Text("Ce calcul des apports de base ne comprend pas les pertes chirurgicales.", style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
// Extrait lignes 1160–1171
1160:                     'Bolus de $remplissagevasc ml de cristalloides en 20 a 30min',
1161:                     style: const TextStyle(fontSize: 14, color: AppColors.textDark),
1162:                   ),
1163:                   children: const [
1164:                     Padding(
1165:                       padding: EdgeInsets.all(8.0),
1166:                       child: Column(
1167:                         crossAxisAlignment: CrossAxisAlignment.start,
1168:                         children: [
1169:                           Text("10 a 20ml/kg en 20 a 30 min", style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
1170:                           Text("Remplissage de SSI ou RL", style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
1171:                         ],
// Extrait lignes 1187–1191
1187:                         children: [
1188:                           Text("Références spécifiques existantes — à valider selon le protocole local :", style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
1189:                           Text("Isopédia", style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
1190:                           Text("RL possible apres 4 ans", style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
1191:                         ],
// Extrait lignes 1205–1223
1205:                 if (agemoistext! >= 24)
1206:                   _DoseRow(name: 'Dexametasone', dose: '${doseDexametasone!.toStringAsFixed(1)} mg', hint: '0.15 mg/kg'),
1207:                 if (agemoistext! >= 1)
1208:                   _DoseRow(name: 'Ondansetron', dose: '${doseOndansetron!.toStringAsFixed(1)} mg', hint: '0.1 mg/ x 3/jour'),
1209:                 if (agemoistext! >= 24)
1210:                   _DoseRow(name: 'Droleptan', dose: '${doseDroleptan!.toStringAsFixed(0)} mcg', hint: '20 mcg/kg (pas pour enfant en ambulatoire)'),
1211:                 _DoseRow(name: 'Spasfon', dose: '${doseSpasfon!} mg', hint: '1 mg/kg/6h'),
1212:               ],
1213:             ),
1214:
1215:             // Equipements
1216:             _MedicalSection(
1217:               title: 'Equipements',
1218:               borderColor: const Color(0xFF8B7EC8),
1219:               icon: Icons.medical_services_outlined,
1220:               children: [
1221:                 _DoseRow(name: 'kt Arteriel', dose: '${ktarteriel!['kt arteriel']}'),
1222:                 _DoseRow(name: 'Catheter veineux central', dose: '${vvc!['vvc']}'),
1223:                 _DoseRow(name: 'Sonde urinaire', dose: '${sad!['sad']}'),
```

</details>

<details>
<summary>lib/posologies_fr.dart</summary>

```dart
// Extrait lignes 1–19
1: // Règles de la deuxième passe française, selon le référentiel fourni.
2: // Les unités font partie des noms pour éviter toute conversion implicite.
3: ({double minimum, int maximum}) calculerPhenylephrineMicrogrammes(int poids) =>
4:     (minimum: poids * 0.5, maximum: poids * 2);
5:
6: ({double minimum, double maximum}) calculerFibrinogeneGrammes(int poids) =>
7:     (minimum: poids * 0.03, maximum: poids * 0.06);
8:
9: double tauxNalbuphineMgKg(int ageEnMois) => ageEnMois < 6 ? 0.1 : 0.2;
10:
11: double calculerNalbuphineMg(int poids, int ageEnMois) =>
12:     poids * tauxNalbuphineMgKg(ageEnMois);
13:
14: /// Contexte hémorragique : charge et, sous 30 kg, débit d'entretien distinct.
15: /// Aucun débit n'est proposé à partir de 30 kg dans le référentiel demandé.
16: ({double chargeMg, double? entretienMgH}) calculerExacyl(int poids) =>
17:     poids < 30
18:         ? (chargeMg: poids * 10.0, entretienMgH: poids * 10.0)
19:         : (chargeMg: 1000.0, entretienMgH: null);
```

</details>

<details>
<summary>lib/reperes_pediatriques.dart</summary>

```dart
// Extrait lignes 1–80
1: /// Repères de la calculette française. Les âges internes sont en mois.
2: int convertirAgeEnMois(int age, {required bool enMois}) =>
3:     enMois ? age : age * 12;
4:
5: double? calculerSeuilHypotension(int ageEnMois) =>
6:     ageEnMois > 12 ? 70 + 2 * (ageEnMois / 12) : null;
7:
8: String formaterNombre(num valeur) => valeur == valeur.roundToDouble()
9:     ? valeur.toInt().toString()
10:     : valeur.toStringAsFixed(1).replaceAll('.', ',');
11:
12: int calculerApportLiquidien(int poids) {
13:   if (poids <= 10) return poids * 4;
14:   if (poids <= 20) return 40 + (poids - 10) * 2;
15:   return 60 + (poids - 20);
16: }
17:
18: enum Chirurgie {
19:   mineure('mineure', 2, 2),
20:   intermediaire('intermédiaire', 4, 6),
21:   majeure('majeure', 6, 10);
22:
23:   const Chirurgie(this.libelle, this.minimum, this.maximum);
24:   final String libelle;
25:   final int minimum;
26:   final int maximum;
27:
28:   String get taux =>
29:       minimum == maximum ? '$minimum ml/kg/h' : '$minimum à $maximum ml/kg/h';
30: }
31:
32: ({double minimum, double maximum}) calculerPertesChirurgicales(
33:         num poids, Chirurgie chirurgie) =>
34:     (
35:       minimum: poids * chirurgie.minimum.toDouble(),
36:       maximum: poids * chirurgie.maximum.toDouble(),
37:     );
38:
39: // Bornes sans chevauchement : nouveau-né <1 mois, puis <12, <24,
40: // <60, <=144 mois. À 2 et 5 ans, entrée dans la tranche suivante.
41: Map<String, String> obtenirConstantesPhysiologiques(int ageEnMois) {
42:   final Map<String, String> valeurs;
43:   if (ageEnMois < 1) {
44:     valeurs = {'FC': '140 - 180', 'PAS': '60 / 35', 'FR': '30 - 60'};
45:   } else if (ageEnMois < 12) {
46:     valeurs = {'FC': '120 - 150', 'PAS': '90 / 65', 'FR': '24 - 40'};
47:   } else if (ageEnMois < 24) {
48:     valeurs = {'FC': '110 - 130', 'PAS': '95 / 65', 'FR': '20 - 30'};
49:   } else if (ageEnMois < 60) {
50:     valeurs = {'FC': '105 - 120', 'PAS': '100 / 60', 'FR': '20 - 30'};
51:   } else if (ageEnMois <= 144) {
52:     valeurs = {'FC': '90 - 110', 'PAS': '110 / 60', 'FR': '16 - 20'};
53:   } else {
54:     valeurs = {'FC': '70 - 100', 'PAS': '120 / 65', 'FR': '16 - 20'};
55:   }
56:   if (ageEnMois < 1) {
57:     valeurs['Hypotension'] = 'si PAM < âge gestationnel à la naissance (SA)';
58:   } else {
59:     final seuil = calculerSeuilHypotension(ageEnMois);
60:     if (seuil != null) {
61:       valeurs['Hypotension'] = 'si PAS < ${formaterNombre(seuil)} mmHg';
62:     }
63:   }
64:   return valeurs;
65: }
66:
67: Map<String, String> obtenirTailleguedel(int ageEnMois) {
68:   if (ageEnMois < 1) {
69:     return {'tailleguedel': '000 ou 00 (transparente / bleue)'};
70:   }
71:   if (ageEnMois < 12) return {'tailleguedel': '0 (grise)'};
72:   if (ageEnMois < 60) return {'tailleguedel': '1 (blanche)'};
73:   return {'tailleguedel': '2 ou 3 (verte / orange)'};
74: }
75:
76: Map<String, String> obtenirCircuit(int poids) {
77:   if (poids < 5) return {'circuit': 'Neonat'};
78:   if (poids < 25) return {'circuit': 'pediatrique'};
79:   return {'circuit': 'adulte'};
80: }
```

</details>

<details>
<summary>lib/antibiotique.dart</summary>

```dart
// Extrait lignes 107–116
107:             _AntibioSection(
108:               title: 'Antibioprophylaxie',
109:               borderColor: AppColors.pastelGreen,
110:               icon: Icons.medication_outlined,
111:               children: [
112:                 _AntibioDoseRow(name: 'Cefazoline', dose: '$doseCefazoline mg', hint: '30 mg/kg, si duree > 4h refaire la meme dose'),
113:                 _AntibioDoseRow(name: 'Amoxicilline/acide clavulanique', dose: '$doseAmox mg', hint: '50 mg/kg (max 2g), si duree > 2h refaire la meme dose (max 1g)'),
114:                 _AntibioDoseRow(name: 'Clindamycine', dose: '$doseClindamycine mg', hint: '10 mg/kg (max 900mg), si duree > 4h refaire la meme dose (max 450mg a 600mg suivant les indications)'),
115:                 _AntibioDoseRow(name: 'Gentamicyne', dose: '$doseGentamycine mg', hint: '6 mg/kg dose unique'),
116:                 _AntibioDoseRow(name: 'Cefoxitine', dose: '$doseCefoxitine mg', hint: '40 mg/kg (max 2g), si duree > 2h refaire meme dose (max 1g)'),
// Extrait lignes 128–134
128: }
129:
130: class _AntibioSection extends StatelessWidget {
131:   final String title;
132:   final Color borderColor;
133:   final IconData? icon;
134:   final List<Widget> children;
```

</details>

<details>
<summary>lib/entretien.dart</summary>

```dart
// Extrait lignes 52–69
52:     double volumePerKg;
53:     if (agemoistext! < 1) {
54:       volumePerKg = 95;
55:     } else if (agemoistext! < 2) {
56:       volumePerKg = 90;
57:     } else if (agemoistext! < 13) {
58:       volumePerKg = 80;
59:     } else {
60:       volumePerKg = 70;
61:     }
62:     double totalVolume = poidstext! * volumePerKg;
63:     return "Volume sanguin estime: ${totalVolume.toStringAsFixed(0)} ml";
64:   }
65:
66:   @override
67:   Widget build(BuildContext context) {
68:     return SingleChildScrollView(
69:       child: ResponsiveCenter(
// Extrait lignes 116–117
116:                 _UrgenceDoseRow(name: "Taux d'hemoglobine", dose: '${hb!['hb']}'),
117:                 _UrgenceDoseRow(name: getBloodVolume(), dose: ''),
// Extrait lignes 128–130
128:                           Text("Enfant = 8g/dl", style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
129:                           Text("Si cardiopathie cyanogene: 12g/dl", style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
130:                         ],
// Extrait lignes 145–150
145:                           SizedBox(height: 8),
146:                           Text("Ratio CGR/PFC/PLQ", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textDark)),
147:                           Text("Si enfant > 30 kg : 1/1/1 (CGR/PFC/PLQ)", style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
148:                           Text("Si enfant < 30 kg : 30/20/20 ml/kg (CGR/PFC/PLQ)", style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
149:                         ],
150:                       ),
// Extrait lignes 155–184
155:                   name: 'Volume PFC',
156:                   dose: '${doseminPFC!.toStringAsFixed(0)} - ${dosemaxPFC!.toStringAsFixed(0)} ml',
157:                   hint: '10 a 30ml/kg',
158:                 ),
159:                 _UrgenceDoseRow(
160:                   name: 'Volume plaquettes',
161:                   dose: '${doseminPqt!.toStringAsFixed(0)} - ${dosemaxPqt!.toStringAsFixed(0)} ml',
162:                   hint: '15 a 20ml/kg',
163:                 ),
164:                 _UrgenceDoseRow(
165:                   name: 'Fibrinogene',
166:                   dose: '${doseminFibri!.toStringAsFixed(2)} - ${dosemaxFibri!.toStringAsFixed(2)} g',
167:                   hint: 'Contexte hémorragique : 0,03 g/kg, jusqu’à 0,06 g/kg si choc hémorragique. Administration non systématique.',
168:                 ),
169:                 _UrgenceDoseRow(
170:                   name: 'Exacyl — dose de charge / bolus',
171:                   dose: poidstext! < 30 ? '${doseExacyl!.toStringAsFixed(0)} mg' : '${(doseExacyl! / 1000).toStringAsFixed(0)} g',
172:                   hint: 'Contexte hémorragique : <30 kg, charge de 10 mg/kg ; ≥30 kg, bolus de 1 g.',
173:                 ),
174:                 if (poidstext! < 30)
175:                   _UrgenceDoseRow(
176:                     name: 'Exacyl — entretien après la charge',
177:                     dose: '${calculerExacyl(poidstext!).entretienMgH!.toStringAsFixed(0)} mg/h',
178:                     hint: '10 mg/kg/h au PSE dans ce contexte hémorragique.',
179:                   ),
180:                 _UrgenceDoseRow(
181:                   name: 'Gluconate de calcium',
182:                   dose: '${doseGluconateCamin!.toStringAsFixed(1)} - ${doseGluconateCamax!.toStringAsFixed(0)}mg',
183:                   hint: '7.5 - 15 mg/kg',
184:                 ),
// Extrait lignes 194–213
194:                 _UrgenceDoseRow(
195:                   name: 'Serum Sale Hypertonique',
196:                   dose: '${doseSshmin!.toStringAsFixed(1)} a ${doseSshmax!.toStringAsFixed(0)} ml',
197:                   hint: '6.5 a 10ml/kg',
198:                 ),
199:                 _UrgenceDoseRow(
200:                   name: 'Manitol',
201:                   dose: '$doseManitol a $poidstext g',
202:                   hint: '0.5 a 1g/kg sur 20 min',
203:                 ),
204:                 const Padding(
205:                   padding: EdgeInsets.only(top: 8, bottom: 4),
206:                   child: Text(
207:                     "Si convulsions",
208:                     style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textDark),
209:                   ),
210:                 ),
211:                 _UrgenceDoseRow(name: 'Valium', dose: '$doseValium mg', hint: '0.5 mg/kg en IR'),
212:                 _UrgenceDoseRow(name: 'Rivotril', dose: '${doseRivotril!.toStringAsFixed(1)} mg', hint: '0.05 mg/kg en IV'),
213:               ],
```

</details>

<details>
<summary>lib/memo_pediatrique.dart</summary>

```dart
// Extrait lignes 46–125
46:           ],
47:         ),
48:       );
49:
50:   static const _cards = <Widget>[
51:     _RepereCard(
52:       title: 'Ventilation',
53:       icon: Icons.air_outlined,
54:       accent: AppColors.primaryBlue,
55:       children: [
56:         _GroupLabel('Circuit'),
57:         _RepereRow('<5 kg', 'Néonatal'),
58:         _RepereRow('5 à <25 kg', 'Pédiatrique'),
59:         _RepereRow('≥25 kg', 'Adulte'),
60:         Divider(height: 24, color: AppColors.borderLight),
61:         _RepereRow('Sonde IOT', '(poids / 10) + 3',
62:             detail: 'Diamètre indicatif (mm) · poids en kg'),
63:         _RepereRow('Repère oral', 'diamètre IOT × 3', detail: 'Repère en cm'),
64:         _RepereRow('Aspiration', 'Fr ≈ 2 × diamètre IOT'),
65:         _CardNote(
66:             'Adaptation clinique possible. Les résultats calculés restent issus des tableaux par poids et du repère oral par âge.'),
67:       ],
68:     ),
69:     _RepereCard(
70:       title: 'Guedel',
71:       icon: Icons.medical_services_outlined,
72:       accent: AppColors.accentTeal,
73:       children: [
74:         _RepereRow('Nouveau-né', '000 ou 00', detail: 'Transparente / bleue'),
75:         _RepereRow('<1 an', '0', detail: 'Grise'),
76:         _RepereRow('1 à <5 ans', '1', detail: 'Blanche'),
77:         _RepereRow('5–12 ans', '2 ou 3', detail: 'Verte / orange'),
78:         _RepereRow('>12 ans', '2 ou 3', detail: 'Verte / orange'),
79:       ],
80:     ),
81:     _RepereCard(
82:       title: 'Lame de laryngoscope',
83:       icon: Icons.medical_information_outlined,
84:       accent: Color(0xFF8B7EC8),
85:       children: [
86:         _RepereRow('Nouveau-né', 'Droite 1 ou courbe 0'),
87:         _RepereRow('<1 an', '1'),
88:         _RepereRow('1 à <2 ans', '1'),
89:         _RepereRow('2 à <5 ans', '2'),
90:         _RepereRow('5–12 ans', '3'),
91:         _RepereRow('>12 ans', '3'),
92:         _CardNote(
93:             'Repères par âge. Le résultat calculé reste déterminé par le poids.'),
94:       ],
95:     ),
96:     _RepereCard(
97:       title: 'Masque facial',
98:       icon: Icons.masks_outlined,
99:       accent: AppColors.primaryBlue,
100:       children: [
101:         _RepereRow('Nouveau-né', '0'),
102:         _RepereRow('<1 an', '1'),
103:         _RepereRow('1 à <2 ans', '2'),
104:         _RepereRow('2 à <5 ans', '3'),
105:         _RepereRow('5–12 ans', '3'),
106:         _RepereRow('>12 ans', '4'),
107:       ],
108:     ),
109:     _RepereCard(
110:       title: 'Hémodynamique',
111:       icon: Icons.monitor_heart_outlined,
112:       accent: Color(0xFFB4778F),
113:       children: [
114:         _GroupLabel('Enfant >1 an'),
115:         _RepereRow('PAS limite basse', '70 + (2 × âge en années)',
116:             detail: 'mmHg'),
117:         Divider(height: 24, color: AppColors.borderLight),
118:         _GroupLabel('Nouveau-né'),
119:         _RepereRow('Règle PAM', 'PAM < âge gestationnel à la naissance',
120:             detail: 'Âge gestationnel en SA'),
121:       ],
122:     ),
123:   ];
124: }
125:
```

</details>

### Routes des fiches PDF

```text
lib/urgences/acrenfant.dart:19: body: PdfViewer.asset("assets/pdf/ACR-au-bloc-chez-l-enfant.pdf"),
lib/urgences/anaphylaxienfant.dart:19: body: PdfViewer.asset("assets/pdf/anaphylaxie-pediatrie.pdf"),
lib/urgences/htmenfant.dart:19: body: PdfViewer.asset("assets/pdf/HyperthermieMaligneenfant.pdf"),
lib/urgences/intoxalenfant.dart:20: "assets/pdf/intoxication-Anesthesiques-Locaux-enfant.pdf"),
lib/urgences/iotdiffenfant.dart:19: body: PdfViewer.asset("assets/pdf/iot-difficile-chez-l-enfant.pdf"),
lib/urgences/laryngospasme.dart:19: body: PdfViewer.asset("assets/pdf/laryngospasmepediatrie.pdf"),
lib/urgences/reanne.dart:20: "assets/pdf/reanimation-du-nouveau-ne-en-salle-de-naissance.pdf"),
```

## Intégrité de la passe

Comparaison SHA-256 des 42 fichiers de `lib`, `test` et `assets` avec les empreintes prises au début de cet audit : **aucune modification, suppression ou création dans ces répertoires**, y compris `lib/english`. Les modifications locales des passes précédentes sont conservées. Le seul nouveau fichier du dépôt créé pendant cet audit est `AUDIT_MEDICAL_PEDIANEST.md`. Les scripts exploratoires sont hors dépôt. Aucun push, aucune PR, aucun déploiement.

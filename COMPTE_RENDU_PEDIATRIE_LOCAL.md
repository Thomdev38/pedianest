## Correction du circuit GitHub → Netlify — 26 septembre 2026

Le commit utilisateur `afdfe50` a bien été envoyé à GitHub et publié par Netlify à 20:44. Netlify utilise `build/web` comme répertoire de base, sans commande de compilation. Ce commit contenait les sources Flutter actualisées mais aucun nouveau fichier de `build/web` : le site servait toujours version 1.0.2, build 27, confirmé par une requête HTTP directe sur `/version.json`.

Cause : lors de la livraison précédente, le build 29 avait été conservé dans `build/livraison-1.0.3-29/netlify`, ignoré par Git ; les fichiers suivis de `build/web` avaient ensuite été remis à leur ancienne version. Cette préparation était adaptée à un dépôt manuel sur Netlify, mais pas au circuit GitHub déjà configuré. Ce n’était pas une perte de fichiers lors du push.

Correction locale : `build/web` synchronisé avec les 46 fichiers de la livraison validée 1.0.3+29 ; anciennes copies compilées imbriquées retirées de ce répertoire. `.gitignore` autorise désormais explicitement `build/web`, tout en continuant à ignorer les autres builds et les archives Android. Les nouveaux fichiers `_headers` et `_redirects` sont visibles par Git sans ajout forcé. Les 43 empreintes des ressources du service worker correspondent aux fichiers présents ; le JavaScript livré contient le texte de Thomas Templier.

**La section précédente qui indiquait de conserver les anciens artefacts suivis est remplacée par cette correction.** GitHub Desktop doit maintenant proposer les modifications de `.gitignore`, `build/web` et de ce compte rendu. Aucun commit, push, réglage Netlify ou déploiement n’a été effectué par l’assistant pendant ce diagnostic. La production restera au build 27 tant que cette correction locale n’aura pas été commitée et poussée par l’utilisateur.

## Livraison locale — carte Divers et build 29

26 septembre 2026 : carte « À propos des posologies pédiatriques » ajoutée en tête de Divers, texte utilisateur intégral, fond clair, bordure légère, icône discrète, coins arrondis et paragraphes aérés. Mention finale en 13,5 px, avec contraste lisible. Mise en page sans hauteur fixe pour le texte.

Version `pubspec.yaml` : **1.0.3+28 → 1.0.3+29**. Seul `lib/divers.dart` a changé dans `lib` pendant cette passe ; aucun calcul médical ni fichier anglais modifié (SHA-256 comparés).

Livrables dans `build/livraison-1.0.3-29/` :

- `pedianesth-1.0.3+29.aab` : release signé, versionName 1.0.3 et versionCode 29 vérifiés ; signature vérifiée avec jarsigner.
- `pedianesth-netlify-1.0.3+29.zip` et dossier `netlify/` : build web release à héberger à la racine `/`, CanvasKit local, manifest et service worker PWA. Ancienne copie imbriquée `web/pwa` et ancien `app.html` exclus du paquet ; inventaire du service worker ajusté en conséquence. Les 43 ressources référencées ont été contrôlées par empreinte MD5.
- `LIRE-MOI.txt` et `SHA256SUMS.txt` : mode de dépôt et empreintes des archives.

Les fichiers de livraison sont conservés dans le dossier dédié ; les anciens artefacts suivis par Git dans `build/web` ont été remis dans leur état initial après copie, afin de ne pas mélanger sources et livraison. Utiliser le dossier `netlify/` de cette livraison pour le nouveau build.

Validation : **87 tests réussis** ; analyze conserve un seul avertissement préexistant sur `backgroundColor` (`lib/homepage.dart:500:10`). Compilations Android et web réussies. `git diff --check` réussi. Aucun push, aucune PR, aucun déploiement.

---

> Mise à jour après audit — 26 septembre 2026 : la passe ci-dessous remplace les descriptions antérieures concernant la succinylcholine et le rémifentanil. Le rapport AUDIT_MEDICAL_PEDIANEST.md reste la photographie de l’état avant ces corrections.

## Succinylcholine IV et rémifentanil en perfusion

Sur instruction explicite de l’utilisateur :

- Succinylcholine pour intubation IV : avant 12 mois, 2 mg/kg ; dès 12 mois, plage 1 à 1,5 mg/kg. Frontière à 18 mois supprimée. Les résultats gardent les demi-milligrammes, sans intégration de dose IM.
- Rémifentanil : plage numérique existante 0,2–0,5 désormais exprimée en µg/kg/min, avec adaptation à la réponse clinique ; résultat pondéral en µg/min, dans une carte « Rémifentanil — perfusion IV ». Aucun protocole de bolus pédiatrique n’ayant été retenu, aucune dose de bolus n’est ajoutée. Pas de conversion en ml/h sans concentration.
- Titre englobant devenu « Doses d’anesthésie » pour inclure la perfusion sans la présenter comme une injection d’induction.
- Les variables du rémifentanil portent désormais explicitement le sens de débit et l’unité µg/min.

Le [RCP Rémifentanil Viatris](https://base-donnees-publique.medicaments.gouv.fr/medicament/68115596/extrait) distingue bolus et perfusion, et prévoit une adaptation à la réponse du patient. La plage mise en œuvre ici est celle conservée sur demande ; cela ne constitue pas une validation nouvelle de toutes les indications ou tranches d’âge. Les autres réserves médicales de l’audit restent à examiner séparément.

Fichiers applicatifs/tests modifiés : `lib/homepage.dart`, `lib/posologies_fr.dart`, `test/posologies_fr_test.dart`. Compte rendu mis à jour ici. Aucun autre fichier de `lib`, `test` ou `assets` modifié dans cette passe (comparaison SHA-256), notamment aucun fichier de `lib/english` ni PDF d’urgence.

Validation : six nouveaux tests de parcours à 360 px (nouveau-né, 6 mois, 11 mois, 12 mois, 2 ans, 10 ans), contrôles du débit rémifentanil actualisés sur cinq poids ; **87 tests réussis**. `flutter analyze` : seul avertissement préexistant `unused_element_parameter`, `backgroundColor`, `lib/homepage.dart:500:10`, sortie 1. `git diff --check` : réussi. Aucun push, aucune PR, aucun déploiement.

---

# Corrections pédiatriques françaises — 26 septembre 2026

Les sections 1 à 7 retracent la première passe validée. La deuxième passe et
la section « À vérifier médicalement » ci-dessous décrivent l’état actuel :
78 tests réussis, un avertissement préexistant dans flutter analyze.

Travail exclusivement local sur Thomdev38/pedianest. Aucun push, aucune PR,
aucun déploiement. Aucun fichier de `lib/english` modifié. Aucun changement
de dépendance. Architecture générale conservée ; seules les règles ciblées
ont été sorties de l’état du widget pour être testables indépendamment.

## 1. Fichiers modifiés ou créés

- `lib/homepage.dart` : intégration des calculs, présentation morphine et
  fluidothérapie, affichage conditionnel de l’hypotension, mémo et adaptation
  des cartes aux petits écrans.
- `lib/reperes_pediatriques.dart` (nouveau) : règles françaises testables
  (conversion d’âge, hypotension, 4-2-1, constantes, pertes, Guedel et circuit).
- `lib/memo_pediatrique.dart` (nouveau) : composant repliable, fermé par défaut.
- `test/reperes_pediatriques_test.dart` (nouveau) : 48 tests unitaires.
- `test/widget_test.dart` : remplacement du test de compteur par 8 tests du
  parcours réel et du mémo.
- Ce compte rendu.

## 2. Erreurs et écarts constatés avant modification

- Hypotension calculée avec `âge saisi + 70`, sans facteur 2 ni conversion
  de la saisie en mois pour cette formule.
- Tranche 2–5 ans : PA 110/60 et FR 16–20 au lieu de 100/60 et 20–30.
- Tranche 5–12 ans manquante : dès plus de 5 ans, valeurs des plus de 12 ans.
- Règle de PAM néonatale affichée pour tous les nourrissons jusqu’à 12 mois.
- Guedel : taille 1 à 5 ans exactement, puis seulement taille 2 jusqu’à 12 ans.
- Compensation du jeûne présentée comme une règle générale de volume à
  remplacer sur deux heures (50 % / 50 %).
- Charge de morphine et titration regroupées dans un seul libellé.
- Le test existant cherchait un compteur absent de l’application : échec
  confirmé avant toute modification.
- Les tests sur écran de 360 px ont révélé des débordements des titres et de
  la carte des constantes ; retour à la ligne et hauteur adaptable corrigés
  dans le fichier français.

## 3. Corrections et décisions

- Morphine IV postopératoire : charge conservée à 0,1 mg/kg IV lente ; seconde
  ligne distincte pour les bolus de 25–50 µg/kg après la charge, avec
  réévaluation toutes les 5 minutes selon protocole et réponse clinique.
  Aucun remplacement par 40 µg/kg. Autres morphines inchangées.
- Règle 4-2-1 conservée et explicitée ; aucune addition automatique des pertes.
- Trois estimations chirurgicales affichées avec taux et conversions en ml/h
  pour le poids calculé : 2, 4–6 et 6–10 ml/kg/h. Mention explicite qu’il ne
  s’agit pas d’une prescription automatique.
- Ancienne compensation du jeûne retirée, remplacée par le texte demandé sur
  l’absence de compensation systématique en chirurgie élective avec jeûne
  conforme, et l’adaptation clinique. Berry, facultative dans la demande,
  n’a pas été ajoutée pour ne pas surcharger l’écran.
- Information générale sur le cristalloïde isotoniquement équilibré ajoutée.
  Isopédia, « RL possible apres 4 ans » et « Remplissage de SSI ou RL »
  conservés. Les références spécifiques sont identifiées comme devant être
  validées selon le protocole local ; aucun choix médical arbitraire effectué.
- Hypotension : âge interne en mois puis division réelle par 12 ; formule
  appliquée strictement après 12 mois. Aucun arrondi à l’année entière.
  Affichage à une décimale si nécessaire, sans décimale pour 74, 80, 90.
- Bornes retenues pour éviter le chevauchement des tableaux : nouveau-né
  <1 mois (0 mois avec la saisie entière existante), puis [1,12), [12,24),
  [24,60), [60,144] mois, puis >144 mois. Ainsi, 2 et 5 ans entrent dans
  la tranche suivante, 12 ans reste dans 5–12 ans. Tests aux limites.
- Guedel : nouveau-né 000/00, 1 à <12 mois 0, 1 à <5 ans 1, dès 5 ans 2/3.
- Circuit : seuils stricts du référentiel appliqués. À 5 kg : pédiatrique ;
  à 25 kg : adulte. Ce changement aux deux bornes est explicite et testé.
- Mémo : circuits, formules pédagogiques IOT/aspiration, Guedel, lames et
  masques par âge, hypotension. Le PDF p. 4 précise bien masque 4 pour **>12
  ans**, et non à 12 ans. Les résultats existants de lame par poids,
  sonde IOT/aspiration par poids et repère oral par âge sont conservés ;
  le mémo explique la différence avec les repères pédagogiques.

Référentiel fourni : *Le Ti’ Pierre pratique (ou guide de survie en anesthésie
du marmaille)*, Dr Marie Anaïs : matériel p. 4, hémodynamique p. 6, solutés p. 7,
morphine p. 11. La page 4 a aussi été vérifiée visuellement.

## 4. Calculs avant / après

| Cas | Avant | Après |
| --- | --- | --- |
| Hypotension, saisie 2 ans | 72 mmHg | 74 mmHg |
| Hypotension, saisie 5 ans | 75 mmHg | 80 mmHg |
| Hypotension, saisie 10 ans | 80 mmHg | 90 mmHg |
| Hypotension, saisie 24 mois | 94 mmHg | 74 mmHg |
| Hypotension, saisie 60 mois | 130 mmHg | 80 mmHg |
| Apport de base 5 / 15 / 25 kg | 20 / 50 / 65 ml/h | Identique |
| Morphine, 20 kg | 2 mg et titration dans le même libellé | Charge 2 mg ; bolus 500–1000 µg distincts |
| Pertes chirurgicales, 20 kg | Absentes | Mineure 40 ; intermédiaire 80–120 ; majeure 120–200 ml/h |
| Constantes à 4 ans : FC, PA, FR | 105–120 ; 110/60 ; 16–20 | 105–120 ; 100/60 ; 20–30 |
| Constantes à 8 ans : FC, PA, FR | 70–100 ; 120/65 ; 16–20 | 90–110 ; 110/60 ; 16–20 |
| Guedel à 5 ans | 1 blanche | 2 verte / 3 orange |
| Guedel à 8 ans | 2 verte | 2 verte / 3 orange |
| Circuit à 5 / 25 kg | Néonatal / pédiatrique | Pédiatrique / adulte |

Les valeurs de PAS sont des seuils : l’hypotension est affichée avec le signe
strict `<`, conformément à la demande.

## 5. Tests ajoutés

48 tests unitaires :

- 4-2-1 : 0, 5, 10, 15, 20 et 25 kg.
- Hypotension : 2, 5, 10 ans ; 24, 60 et 18 mois ; seuil strict >12 mois
  et conversion fractionnaire à 13 mois.
- Constantes : 0, 1, 6, 11, 12, 18, 23, 24, 48, 59, 60, 96, 144, 145,
  156 mois (dont tous les cas demandés et les limites).
- Pertes : 5, 20 et 25 kg, chacun avec les trois niveaux.
- Guedel : 0, 1, 11, 12, 24, 59, 60, 61, 144 et 145 mois.
- Circuit : 4, 5, 24 et 25 kg.

8 tests de widgets :

- 5 parcours de saisie et calcul : 2 ans, 24 mois, 5 ans, 60 mois, 10 ans.
- Passage nouveau-né → 6 mois : suppression de la règle de PAM néonatale.
- Mémo fermé par défaut, ouverture/fermeture, présence lames/masques/Guedel.
- Écran de 360 px : conservation des autres morphines et de la lame calculée
  par poids, références de solutés accessibles, 4-2-1 dépliable, absence
  d’ancienne compensation du jeûne, recalcul après modification du poids.

## 6. Résultat flutter analyze

Commande : `C:\flutter\bin\flutter.bat analyze`.

**0 erreur, 1 avertissement préexistant ; code de sortie 1.**

`lib/homepage.dart:496:10` : `unused_element_parameter` pour le paramètre
facultatif `backgroundColor`, jamais fourni. Même avertissement observé
avant les modifications (ancienne ligne 562). La propriété a été conservée
car elle est indépendante des corrections demandées.

Environnement : Flutter 3.35.7, Dart 3.9.2.

## 7. Résultat des tests et contrôles

Commande : `C:\flutter\bin\flutter.bat test --reporter expanded`.

**56 tests réussis, 0 échec ; code de sortie 0.**

`git diff --check` réussi. `git diff --exit-code -- lib/english` réussi :
aucune modification anglaise. Aucun push, PR ou déploiement.

## Deuxième passe ciblée

### Fichiers modifiés pendant cette passe

- `lib/homepage.dart` : branchement des calculs corrigés, unités et aides.
- `lib/entretien.dart` : fibrinogène et Exacyl dans « Blood management ».
- `lib/posologies_fr.dart` (nouveau) : calculs testables avec unités explicites.
- `test/posologies_fr_test.dart` (nouveau) : 22 tests supplémentaires.
- Ce compte rendu, mis à jour.

Les autres fichiers de la première passe sont conservés. Aucun changement
anglais, aucun push, aucune PR, aucun déploiement. La comparaison au début de
cette passe confirme que les formules et les lignes d’affichage Fentanyl,
Actiskenan et Skenan sont strictement inchangées.

### Diagnostic Exacyl effectué avant correction

- Avant cette passe, `lib/homepage.dart:290` calculait `poids * 20` pour
  `doseExacyl`, puis transmettait cette valeur à `UrgencePage`.
- `lib/entretien.dart:169–171` affichait « Exacyl », sous l’onglet **Urgences**,
  carte **Blood management**, avec les autres produits du contexte transfusionnel.
- Le résultat était `20 × poids` mg pour **poids ≤30 kg**, et « 1g » au-delà.
- L’aide indiquait pourtant « 10 mg/kg si <30 kg sinon 1g puis 10mg/kg/h PSE ».
  Elle ne distinguait pas la charge de la perfusion et pouvait laisser penser
  que la perfusion concernait également les patients ≥30 kg.
- Le référentiel précisé dans votre deuxième demande fixe explicitement
  **<30 kg : charge 10 mg/kg puis 10 mg/kg/h ; ≥30 kg : bolus 1 g**.
  La correction est donc sans ambiguïté selon vos instructions : charge
  corrigée, frontière 30 kg corrigée, ligne d’entretien séparée sous 30 kg
  uniquement. Aucune perfusion ajoutée à partir de 30 kg.
- État actuel : calcul dans `lib/posologies_fr.dart:16`, affichage dans
  `lib/entretien.dart:170` et `:176`. Contexte hémorragique explicite.

### Corrections et exemples avant / après

| Élément | Avant | Après |
| --- | --- | --- |
| Néosynéphrine, 20 kg | « 10.0 - 40 mg » | « 10.0 - 40 µg » ; coefficients 0,5–2 inchangés, aide bolus/max 10 µg/kg explicite |
| Rémifentanil, 20 kg | Calcul 4–10 µg ; aide 20–40 µg/kg | Même calcul, aide 0,2–0,5 µg/kg |
| Fibrinogène, 20 kg | 1,20–0,60 g | 0,60–1,20 g ; 0,03 g/kg jusqu’à 0,06 g/kg si choc hémorragique ; non systématique |
| Nalbuphine, 8 kg, 5 mois | 1,6 mg | 0,8 mg, aide 0,1 mg/kg |
| Nalbuphine, 8 kg, 6 ou 7 mois | 1,6 mg | 1,6 mg, aide 0,2 mg/kg |
| Exacyl, 20 kg | 400 mg et aide de perfusion ambiguë | Charge 200 mg, puis entretien distinct 200 mg/h |
| Exacyl, 29 kg | 580 mg | Charge 290 mg, puis entretien 290 mg/h |
| Exacyl, 30 kg | 600 mg | Bolus 1 g ; aucun entretien proposé |
| Exacyl, 31 kg | 1 g et aide de perfusion ambiguë | Bolus 1 g ; aucun entretien proposé |

La correction de Néosynéphrine est une correction de l’unité d’affichage,
pas une conversion des anciens nombres de mg vers µg : les coefficients
étaient déjà ceux demandés en microgrammes. Le fibrinogène reste dans son
contexte hémorragique ; la plage n’est pas présentée comme systématique.

### Tests et contrôles finaux

22 tests supplémentaires : 14 unitaires et 8 tests de widgets.

- Phényléphrine : 5, 20, 31 kg ; vérification des valeurs et affichage µg.
- Fibrinogène : 5, 20, 30 kg ; bornes ordonnées et unité g.
- Nalbuphine : 5, 6, 7 mois à 8 kg ; calcul, saisie en mois et aide cohérente.
- Exacyl : 5, 20, 29, 30, 31 kg ; charge, débit sous 30 kg et absence de
  débit à partir de 30 kg.
- Parcours anesthésie → urgences à ces cinq poids : valeurs et aides
  rémifentanil, phényléphrine, nalbuphine, fibrinogène et Exacyl ; conservation
  des résultats Fentanyl, Actiskenan et Skenan.

Résultats sous Flutter 3.35.7 / Dart 3.9.2 :

- `flutter test --reporter expanded` : **78 tests réussis, 0 échec, sortie 0**.
- `flutter analyze` : **0 erreur, 1 avertissement préexistant, sortie 1**.
  `lib/homepage.dart:499:10`, `unused_element_parameter`, `backgroundColor`.
  Aucun nouvel avertissement ; celui-ci reste hors périmètre.
- `git diff --check` : **réussi, sortie 0**.
- Empreintes SHA-256 de tous les fichiers `lib/english` : identiques à celles
  relevées avant la deuxième passe.

## À vérifier médicalement

Section mise à jour après la deuxième passe. Les incohérences demandées de
Néosynéphrine, fibrinogène, nalbuphine et Exacyl sont corrigées ; l’aide du
rémifentanil correspond désormais au calcul. Les observations restantes
ci-dessous n’ont entraîné aucune modification non demandée.

| Fichier et ligne actuelle | Valeur actuelle conservée | Raison du doute / diagnostic |
| --- | --- | --- |
| `lib/homepage.dart:275–276`, affichage `:952` | Fentanyl : poids × 20 à poids × 50 µg ; aide 20–50 mcg/kg | Apparaît sous **Doses Induction**, carte **Morphiniques**, onglet Anesthesie. Présentation générique d’induction, sans contexte particulier explicite. Aucun commentaire ni source spécifique à cette dose retrouvé dans le code ou la documentation du dépôt ; `lib/sources.dart` donne seulement une bibliographie générale. La version anglaise duplique la valeur, ce qui ne constitue pas une source. Dose et affichage strictement inchangés. |
| `lib/homepage.dart:273–274`, affichage `:951` | Rémifentanil : 0,2–0,5 µg/kg | Calcul inchangé et aide corrigée. Même rubrique d’induction générique, mais bolus/durée/modalité d’administration non précisés. Contexte clinique à confirmer ; aucune modalité inventée. |
| `lib/homepage.dart:316–317`, affichage `:1052`, `:1054` | Actiskenan/Skenan : poids × 1 mg ; aides « 1 mg/kg/j en 6 prises » et « 1 mg/kg/j en 2 prises » | Le résultat est bien le **total journalier**, pas une dose par prise. À 20 kg, affichage principal « 20 mg » pour chaque médicament. L’aide précise /j, mais le nombre principal ne le précise pas : risque de lire 20 mg à chaque prise. On ne peut donc pas garantir l’absence d’ambiguïté UX. Aucun changement de dose ni de libellé dans cette passe, conformément à votre demande. |
| `lib/homepage.dart:205`, `:241`, `:339` | IOT/aspiration par tableaux de poids ; repère oral = âge/2 + 12 cm | Diffèrent des formules pédagogiques du PDF. Mémo explicite de la première passe, calculs inchangés. |
| `lib/homepage.dart:227` | Lame calculée par poids | Diffère du tableau par âge présent dans le mémo ; calcul conservé sur instruction explicite. |
| `lib/homepage.dart:1126`, `:1145`, `:1146` | SSI ou RL ; Isopédia ; RL possible après 4 ans | Choix du soluté, glucose et conditions d’âge à valider selon le protocole local. Références conservées. |

Pour le dernier point, l’[alerte SFAR/ADARPEF sur l’arrêt du B66](https://e-adarpef.fr/publications/alertes/la-fin-programmee-du-solute-b66/)
consultée lors de la première passe décrit des adaptations selon le patient
et le contexte. Aucune modification supplémentaire de soluté ou de dose
n’en a été déduite.

Limite préexistante : saisie de l’âge et du poids en entiers ; ni âge en jours
ni poids décimal n’ont été ajoutés dans ces deux interventions.

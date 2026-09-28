# Guide de contribution

Merci de votre intérêt pour améliorer le générateur de documentation de référence des templates Azure.

Ce guide explique comment configurer votre environnement, faire des changements, tester, et soumettre une pull request (PR).

## Sommaire

- [Avant de commencer](#avant-de-commencer)
- [Configuration de l'environnement](#configuration-de-lenvironnement)
- [Mise à jour des dépendances](#mise-à-jour-des-dépendances)
- [Modifier le code](#modifier-le-code)
- [Modifier la configuration](#modifier-la-configuration)
- [Modifier les samples](#modifier-les-samples)
- [Tests](#tests)
- [Mise à jour des baselines](#mise-à-jour-des-baselines)
- [Soumettre une pull request](#soumettre-une-pull-request)
- [Règles de code](#règles-de-code)
- [Questions](#questions)

## Avant de commencer

1. **Surveillez les issues existantes** : vérifiez si une issue existe déjà pour votre suggestion ou bug. Si oui, commentez l'issue pour indiquer que vous travaillez dessus.
2. **Créez une issue** si nécessaire : si votre idée n'est pas encore discutée, ouvrez une issue pour discuter de la proposition avant de coder.
3. **Lisez le Code of Conduct** : ce projet adopte le [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/). Respectez-le dans toutes vos interactions.

## Configuration de l'environnement

### Prérequis

- [.NET 10.0 SDK](https://dotnet.microsoft.com/en-us/download/dotnet/10.0) (ou version ultérieure)
- [Git](https://git-scm.com/)
- (Optionnel) [Visual Studio Code](https://code.visualstudio.com/) avec l'extension C#
- (Optionnel) [PowerShell](https://github.com/PowerShell/PowerShell) pour les scripts de mise à jour des samples

### Étapes

1. **Fork le repo** sur GitHub.
2. **Clone votre fork** localement.
3. **Ajoutez le repo upstream** comme remote :

```bash
git remote add upstream https://github.com/Azure/template-reference-generator.git
git fetch upstream
```

4. **Créez une branche à partir de main** :

```bash
git checkout -b ma-branche upstream/main
```

### Vérification de l'environnement

Assurez-vous que le build local passe avant de commencer :

```bash
dotnet build
```

## Mise à jour des dépendances

Les dépendances NuGet sont gérées dans `src/Directory.Packages.props`.

Pour mettre à jour une dépendance :

1. Éditez `src/Directory.Packages.props` pour changer la version.
2. Restaurez les packages :

```bash
dotnet restore
```

3. Vérifiez que le build et les tests passent :

```bash
dotnet build
dotnet test
```

### Dépendances NuGet principales

Les packages suivants sont utilisés par le projet :

| Package | Version actuelle | Rôle |
|---------|-----------------|------|
| Azure.Bicep.Types | 0.6.144 | Types Bicep pour les ressources Azure |
| Azure.Bicep.Types.Az | 0.2.813 | Types Az pour les ressources Azure |
| Azure.Deployments.Testing.Utilities | 1.527.0 | Utilitaires pour les tests de déploiement |
| Microsoft.PowerPlatform.ResourceStack | 7.0.0.2076 | Stack de ressources Power Platform |
| CommandLineParser | 2.9.1 | Analyse des arguments CLI |
| MSTest | 3.11.0 | Framework de tests unitaires |
| System.IO.Abstractions | 22.1.1 | Abstraction des I/O pour les tests |
| System.Security.Cryptography.Xml | 8.0.4 | Chiffrement XML |

### Mise à jour automatique

Le repo utilise [Dependabot](https://docs.github.com/en/code-security/dependabot/dependabot-version-updates) pour les mises à jour automatiques des dépendances NuGet et des actions GitHub. Les PRs Dependabot sont automatiquement fusionnées si elles passent les checks CI.

## Modifier le code

### Structure du code

Le code est organisé comme suit :

```text
src/TemplateRefGenerator/
├── MainGenerator.cs           # Point d'entrée principal, orchestre la génération
├── Program.cs                 # Définition de la CLI (CommandLineParser)
├── ResourceTypeProvider.cs   # Fournit les types de ressources depuis bicep-types-az
├── Config/
│   ├── ConfigLoader.cs        # Charge la configuration JSON
│   └── RemarksLoader.cs       # Charge les remarques personnalisées
├── Generators/
│   ├── AllVersionsGenerator.cs   # Génère la vue toutes versions
│   ├── ChangeLogGenerator.cs     # Génère les changelogs
│   ├── CodeSampleGenerator.cs    # Génère les échantillons de code
│   ├── MarkdownGenerator.cs      # Génère les documents Markdown
│   └── TocGenerator.cs          # Génère les tables des matières
├── Utils/
│   ├── JsonHelper.cs           # Utilitaires JSON
│   └── PathHelper.cs           # Utilitaires de chemin
└── TemplateRefGenerator.csproj
```

### Modifier les générateurs

Si vous modifiez un générateur (par exemple, changer le format de sortie Markdown) :
1. Modifiez le code du générateur concerné.
2. Vérifiez que les tests existants passent toujours.
3. Mettez à jour les baselines si nécessaire (voir [Mise à jour des baselines](#mise-à-jour-des-baselines)).
4. Vérifiez visuellement la sortie générée pour vous assurer que le changement est correct.

### Modifier la CLI

Le programme CLI est défini dans `Program.cs` avec [CommandLineParser](https://github.com/commandlineparser/commandline). Pour ajouter un nouvel argument :

1. Définissez la propriété avec l'attribut `[Option]` ou `[Argument]` dans la classe de définition de commande.
2. Mettez à jour la logique dans `MainGenerator` pour utiliser le nouvel argument.
3. Mettez à jour le fichier d'aide si nécessaire.

## Modifier la configuration

### config.json

Le fichier `settings/config/config.json` contient la configuration centrale. Il est validé par le schéma `settings/config.schema.json`.

Pour modifier la configuration :
1. Éditez `settings/config/config.json`.
2. Vérifiez la validité avec un éditeur compatible JSON Schema (ex : VSCode).
3. Testez localement.

### remarks/

Les remarques personnalisées par fournisseur de ressources sont dans `settings/remarks/<provider_namespace>/remarks.json`.

### samples.json

Voir [Modifier les samples](#modifier-les-samples) pour les samples.

## Modifier les samples

Le fichier `settings/samples/samples.json` est **généré automatiquement** par le script `scripts/UpdateSamples.ps1`. Il n'est pas recommandé de le modifier manuellement, car vos changements seraient écrasés par la prochaine exécution du script.

Pour ajouter un sample personnalisé, contactez les mainteneurs ou discutez-en dans une issue.

## Tests

### Exécuter les tests

```bash
dotnet test
```

### Tests spécifiques

```bash
# Tous les tests
dotnet test

# Avec détails
dotnet test --verbosity normal

# Un projet spécifique
dotnet test src/TemplateRefGenerator.Tests/TemplateRefGenerator.Tests.csproj
```

### Couverture de test

La couverture de test n'est pas exigée pour chaque PR, mais pensez à ajouter des tests pour les nouvelles fonctionnalités ou les bugs corrigés.

### Baselines

Les tests de génération utilisent des fichiers de référence ("baselines") pour vérifier que la sortie est correcte. Si votre changement modifie la sortie générée (par exemple, un changement de format, un nouveau champ, une amélioration du texte), vous devez mettre à jour les baselines.

#### Mise à jour des baselines

```bash
# Mettre à jour toutes les baselines
./scripts/update_baselines.sh
```

Si vous ne pouvez pas exécuter le script (par exemple, sur Windows sans bash), suivez les instructions dans le message d'erreur du test qui devrait vous donner la commande exacte pour mettre à jour la baseline spécifique.

## Soumettre une pull request

### Processus

1. **Validez vos changements** :

```bash
git add .
git commit -m "Description concise du changement"
```

Suivez les conventions de commit : commencez par un verbe d'action (ex : "Fix", "Add", "Update", "Bump").

2. **Pushez votre branche** :

```bash
git push origin ma-branche
```

3. **Ouvrez une PR** sur GitHub depuis votre branche vers `Azure/template-reference-generator/main`.
4. **Remplissez le formulaire de PR** :
   - **Titre** : clair et concis (ex : "Fix typo in MarkdownGenerator", "Bump Azure.Bicep.Types to 0.7.0").
   - **Description** : expliquez ce que vous changez, pourquoi, et comment vous l'avez testé.
   - **Lien vers l'issue** : si applicable, référencez l'issue avec "Fixes #<numero>" ou "Relates to #<numero>".
5. **Attendez la validation** :
   - Le bot CLA déterminera si vous devez signer un CLA. Suivez les instructions si besoin.
   - Les checks CI (`ci.yml`) s'exécuteront automatiquement.
   - Un mainteneur examinera votre PR.

### Bonnes pratiques

- **PRs petites et ciblées** : une PR par fonctionnalité ou correction.
- **Description complète** : incluez le contexte, le "pourquoi", et les tests effectués.
- **Tests ajoutés/modifiés** : si vous ajoutez une fonctionnalité ou corrigez un bug, ajoutez ou mettez à jour les tests.
- **Pas de changements inutiles** : évitez les reformattages massifs ou les changements non liés à la PR.

## Règles de code

### Bonnes pratiques C#

- Suivez les conventions de style C# standard (PascalCase pour les types et méthodes, camelCase pour les variables locales).
- Les projets ont les analyzers activés (`EnableNETAnalyzers`, `EnforceCodeStyleInBuild`).
- Utilisez `System.IO.Abstractions` pour les I/O afin de faciliter les tests.
- Préférez `Path.Combine` pour la construction des chemins.
- Les variables et champs sont en camelCase, les méthodes et types en PascalCase.
- Les expressions de requête (LINQ) sont préférées aux boucles when readable.

### Style du projet

Le projet utilise `dotnet format` pour le formatage. Assurez-vous que votre code est bien formaté avant de soumettre :

```bash
dotnet format
```

## Questions

Si vous avez des questions :

1. **Recherchez dans le repo** : issues, discussions, et documentation existante.
2. **Ouvrez une issue** : si votre question est d'ordre général ou technique.
3. **Contactez les mainteneurs** : via les issues GitHub ou le canal approprié.

---

Merci de votre contribution ! 

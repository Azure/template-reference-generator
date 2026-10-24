# Template Reference Generator

Ce repo contient le code pour générer la [documentation de référence des templates Azure](https://learn.microsoft.com/azure/templates/).

Le générateur consomme les types Bicep du repo [Azure/bicep-types-az](https://github.com/Azure/bicep-types-az) (dossier `generated/`) et produit des fichiers Markdown organisés par fournisseur de ressources et par version. Ces documents sont publiés sur [learn.microsoft.com/azure/templates](https://learn.microsoft.com/azure/templates/).

## Table des matières

- [Prérequis](#prérequis)
- [Architecture](#architecture)
- [Installation](#installation)
- [Génération](#génération)
- [Configuration](#configuration)
- [Tests](#tests)
- [Mise à jour des samples](#mise-à-jour-des-samples)
- [Workflow CI/CD](#workflow-cicd)
- [Contribution](#contribution)

## Prérequis

- [.NET 10.0 SDK](https://dotnet.microsoft.com/en-us/download/dotnet/10.0) ou version ultérieure
- [bicep-types-az](https://github.com/Azure/bicep-types-az) généré et disponible localement (dossier `generated/`)

## Architecture

```text
template-reference-generator/
├── src/
│   ├── TemplateRefGenerator/          # Application CLI principale (C#)
│   │   ├── MainGenerator.cs           # Orchestre principal
│   │   ├── ResourceTypeProvider.cs   # Lecture des types Bicep
│   │   ├── Generators/               # Moteurs de génération
│   │   │   ├── AllVersionsGenerator.cs
│   │   │   ├── ChangelogGenerator.cs
│   │   │   ├── CodeSampleGenerator.cs
│   │   │   ├── MarkdownGenerator.cs
│   │   │   └── TocGenerator.cs
│   │   └── Config/                   # Configuration (ConfigLoader, RemarksLoader)
│   └── TemplateRefGenerator.Tests/   # Tests unitaires (MSTest)
├── settings/
│   ├── config/config.json            # Configuration centrale
│   ├── remarks/                      # Remarques par fournisseur de ressources
│   ├── samples/samples.json          # Liens vers samples
│   └── schemas/                      # Schémas JSON de validation
├── scripts/
│   ├── run.sh                        # Script de lancement
│   ├── update_baselines.sh           # Mise à jour des snapshots de tests
│   └── UpdateSamples.ps1             # Mise à jour des samples
├── docs/
│   ├── dev_guide.md                  # Guide développeur
│   └── configuration.md              # Guide de configuration
└── .github/
    └── workflows/
        ├── ci.yml                    # Build + tests
        ├── generate.yml              # Génération des docs
        └── update-samples.yml        # Mise à jour des samples
```

### Flux de génération

1. `ResourceTypeProvider` lit les fichiers de types dans `source-folder` (généré par bicep-types-az).
2. `MainGenerator` orchestre la génération pour chaque fournisseur de ressources et version.
3. Les générateurs produisent :
   - **Markdown** : documentation par resource type.
   - **TOC** : table des matières par fournisseur.
   - **Code samples** : échantillons de code.
   - **Changelog** : journal des modifications par version.
   - **AllVersions** : vue globale de toutes les versions.

## Installation

```bash
# Cloner le repo
git clone https://github.com/Azure/template-reference-generator.git
cd template-reference-generator

# Installer les dépendances
dotnet restore

# Vérifier que le build local passe
dotnet build
```

Assurez-vous d'avoir le SDK .NET 10.0 (ou version ultérieure) installé. La version exacte est définie dans `global.json` (actuellement 10.0.401).

## Génération

### Préparer bicep-types-az

Clonez et générez le repo [Azure/bicep-types-az](https://github.com/Azure/bicep-types-az) à côté de ce repo :

```bash
cd ..
git clone https://github.com/Azure/bicep-types-az.git
cd bicep-types-az
# Suivez les instructions du README pour générer les types
cd ../template-reference-generator
```

### Lancer la génération

```bash
# Méthode 1 : via le script
./scripts/run.sh

# Méthode 2 : via dotnet run directement
dotnet run --configuration Release --project ./src/TemplateRefGenerator   --source-folder ../bicep-types-az/generated   --output-folder ./generated   --verbose
```

Les arguments CLI disponibles :

| Argument | Description |
|----------|-------------|
| `--source-folder` | Chemin vers le dossier `generated/` de bicep-type-az (obligatoire) |
| `--output-folder` | Dossier de sortie pour les documents générés (obligatoire) |
| `--verbose` | Affiche les logs détaillés |

### Résultat

Les fichiers générés sont créés dans `output-folder/` avec la structure :

```text
output-folder/
├── <provider_namespace>/
│   ├── <api_version>/
│   │   ├── <resource_type>.md
│   │   └── ...
│   ├── toc.md
│   └── ...
├── changelogs/
│   └── ...
└── toc/
    └── ...
```

## Configuration

Le comportement du générateur peut être personnalisé via les fichiers dans `settings/` :

### config.json

Fichier de configuration centrale. Contient :
- **`TocTitleMapping`** : mapping des titres de page pour les namespaces de fournisseurs de ressources.
- **`ExcludedProviders`** : liste des namespaces de fournisseurs exclus de la génération.

Voir [docs/configuration.md](docs/configuration.md) pour le détail complet.

### remarks/

Remarques personnalisées par fournisseur de ressources. Chaque fichier `remarks.json` dans `settings/remarks/<provider_namespace>/` peut contenir :
- **`DeploymentRemarks`** : remarques markdown sur le déploiement d'un type de ressource.
- **`ResourceRemarks`** : remarques markdown sur un type de ressource spécifique.
- **`PropertyRemarks`** : description personnalisée pour une propriété d'un type de ressource.
- **`BicepSamples`** / **`ArmTemplateSamples`** / **`TerraformSamples`** : échantillons de code.

### samples.json

Liens vers des samples externes. Ce fichier est **généré automatiquement** par le script `UpdateSamples.ps1` (voir [Mise à jour des samples](#mise-à-jour-des-samples)). Il rassemble :
- **`QuickstartLinks`** : liens vers les templates Azure Quickstart.
- **`AvmLinks`** : liens vers les modules Azure Verified Modules (Bicep et Terraform).

## Tests

```bash
# Exécuter tous les tests
dotnet test

# Exécuter avec détails
dotnet test --verbosity normal
```

### Mise à jour des baselines

Si un test échoue à cause d'un changement attendu dans la sortie, les baselines doivent être mises à jour :

```bash
# Mettre à jour toutes les baselines
./scripts/update_baselines.sh

# Ou suivre les instructions dans le message d'erreur du test
```

## Mise à jour des samples

Le fichier `settings/samples/samples.json` est mis à jour par le script PowerShell `UpdateSamples.ps1`, qui récupère les liens depuis :
- [Azure/azure-quickstart-templates](https://github.com/Azure/azure-quickstart-templates)
- [Azure/Azure-Verified-Modules](https://github.com/Azure/Azure-Verified-Modules) (Bicep et Terraform)

```bash
# Exécuter la mise à jour des samples (nécessite PowerShell)
./scripts/UpdateSamples.ps1 -QuickStartsRepoPath ../azure-quickstart-templates
```

Un workflow GitHub Actions (`update-samples.yml`) exécute cette mise à jour hebdomadairement (dimanche midnight) et pousse les changements sur la branche `update-samples`.

## Workflow CI/CD

### CI (`ci.yml`)

S'exécute à chaque `push` sur `main`, chaque `pull_request` sur `main`, et manuellement (`workflow_dispatch`).

```yaml
- Setup .NET SDK
- dotnet build
- dotnet test
```

### Generate (`generate.yml`)

S'exécute :
- **Hébdomadairement** : dimanche 9h00 UTC (cron `0 9 * * SUN`)
- **Manuellement** : via `workflow_dispatch` avec un paramètre `types_az_ref` (ref Git ou SHA de bicep-types-az)

La génération clone bicep-types-az, lance le générateur, upload l'artifact `generated` et affiche le résumé du job.

### Update Samples (`update-samples.yml`)

S'exécute :
- **Hébdomadairement** : dimanche midnight UTC (cron `0 0 * * SUN`)
- **Manuellement** : via `workflow_dispatch`

Il clone azure-quickstart-templates, exécute `UpdateSamples.ps1`, met à jour les baselines, et pousse sur la branche `update-samples` avec le commit "Update Quickstart & AVM samples".

## Contribution

Voir le fichier [CONTRIBUTING.md](CONTRIBUTING.md) pour toutes les informations sur la façon de contribuer à ce projet.

---

## Liens utiles

- [Azure Template Reference Documentation](https://learn.microsoft.com/azure/templates/)
- [Azure/bicep-types-az](https://github.com/Azure/bicep-types-az)
- [Azure Quickstart Templates](https://github.com/Azure/azure-quickstart-templates)
- [Azure Verified Modules](https://github.com/Azure/Azure-Verified-Modules)
- [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/)
- [Contributor License Agreement (CLA)](https://cla.opensource.microsoft.com)

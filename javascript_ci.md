1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
29
30
31
32
33
34
35
36
37
38
39
40
41
42
43
44
45
46
47
48
49
50
51
52
53
54
55
56
57
58
59
60
61
62
63
64
65
66
67
68
69
70
71
72
73
74
75
76
77
78
79
80
81
82
83
84
85
86
87
88
89
90
91
92
93
94
95
96
97
98
99
100
101
102
103
104
105
106
107
108
109
110
111
112
113
114
115
116
117
118
119
120
121
122
123
124
125
126
127
128
129
# Easy CI/CD for JavaScript/TypeScript projects

- [Easy CI/CD for JavaScript/TypeScript projects](#easy-cicd-for-javascripttypescript-projects)
  - [Summary](#summary)
    - [Easy CI/CD Zen](#easy-cicd-zen)
    - [What it does](#what-it-does)
    - [What it does not](#what-it-does-not)
  - [Secrets](#secrets)
  - [Workflows](#workflows)
    - [Update Pull Request labels](#update-pull-request-labels)
    - [Update Release draft from Pull Request notes](#update-release-draft-from-pull-request-notes)
    - [Create release Pull Request on Release](#create-release-pull-request-on-release)
    - [Publish to NPM on Release Pull Request merged](#publish-to-npm-on-release-pull-request-merged)
    - [Create or update a Release draft from Unreleased notes](#create-or-update-a-release-draft-from-unreleased-notes)

GitHub Actions for automated JavaScript/TypeScript projects.

## Summary

### Easy CI/CD Zen

- Write Release and Pull Request notes in [Keep a Changelog](https://keepachangelog.com/en/1.0.0/) format
- Follow [SemVer](https://semver.org/) versioning schema
- Noone likes to write and assemble Release notes, so leave it to automation
- Always leave a final decision to a human in case automation goes crazy
- Enforce best practices for versioning and changelog in a passive-aggressive way

### What it does

- Enforces [SemVer](https://semver.org/) versioning schema
- Release and Pull Request notes follow [Keep a Changelog](https://keepachangelog.com/en/1.0.0/) format
- Supports publishing new versions to [npm](https://www.npmjs.com/)
- Automatically bumps version in `package.json` and adds published Release notes to `CHANGELOG.md`
- Releases are build in `release/*` branches to prevent unwanted changes 

### What it does not

- There are no workflows to run linting, type checking or unit tests, so this is up to you
- Does not update files in your branches, ll updates happen in newly created `release/*`,
  so you can always check that automation does exactly what you want
- Does not analyze your project files to suggest versions, all suggested versions are based
  only on Release/Pull Request notes

## Secrets

- `NPM_TOKEN` - If set, new version is published to [npm](https://www.npmjs.com/)

## Workflows

### Update Pull Request labels

Workflow: [on_pull_opened_or_edited.yml](nodejs_workflows/on_pull_opened_or_edited.yml)

- Starts on Pull Request opened or edited event
- Pull Request notes must be in [Keep a Changelog](https://keepachangelog.com/en/1.0.0/) format
- If Pull Request branch name is `release/*`, adds `release` label
- If Pull Request notes has `Removed` section, adds `major` label
- If Pull Request notes has `Added`, `Changed` or `Deprecated` sections, adds `minor` label
- Otherwise adds `patch` label

```bash
# download workflows to GitHub Action directory
# run this command from a GitHub repository root
curl https://github.com/vemel/nextversion/blob/main/nodejs_workflows/on_pull_opened_or_edited.yml -o nodejs_workflows/on_pull_opened_or_edited.yml
```

### Update Release draft from Pull Request notes

Workflow: [on_pull_merged.yml](nodejs_workflows/on_pull_merged.yml)

- Starts on Pull Request merge for non-`release/*` branch
- Creates or updates a Release draft for Pull Request base branch
- Release draft notes are merged from existing notes and Pull Request notes
- Each entry added from Pull Request notes contains a link to the Pull Request 
- Release draft suggested version is based on Release notes

```bash
# download workflows to GitHub Action directory
# run this command from a GitHub repository root
curl https://github.com/vemel/nextversion/blob/main/nodejs_workflows/on_pull_merged.yml -o nodejs_workflows/on_pull_merged.yml
```

### Create release Pull Request on Release

Workflow: [on_release_published.yml](nodejs_workflows/on_release_published.yml)

- Starts on Release published
- Release notes must be in [Keep a Changelog](https://keepachangelog.com/en/1.0.0/) format
- Creates a Release Pull Request from Release target branch with `release` label
- Release Pull Request contains only version bump in `package.json` and updated `CHANGELOG.md`
- Release Pull Request uses branch `release/<version>`

```bash
# download workflows to GitHub Action directory
# run this command from a GitHub repository root
curl https://github.com/vemel/nextversion/blob/main/nodejs_workflows/on_release_published.yml -o nodejs_workflows/on_release_published.yml
```

### Publish to NPM on Release Pull Request merged

Workflow: [on_release_pull_merged.yml](nodejs_workflows/on_release_pull_merged.yml)

- Starts on Pull Request merge for `release/*` branch
- Uses Pull Request branch for deployment, so released version contains only changes
  from base branch when Release had been published
- Runs `npm run build` if this command is available
- Publishes new version to [npm](https://www.npmjs.com/) if `NPM_TOKEN` secret is set

```bash
# download workflows to GitHub Action directory
# run this command from a GitHub repository root
curl https://github.com/vemel/nextversion/blob/main/nodejs_workflows/on_release_pull_merged.yml -o nodejs_workflows/on_release_pull_merged.yml
```

### Create or update a Release draft from Unreleased notes

Workflow: [on_demand_create_release_draft.yml](nodejs_workflows/on_demand_create_release_draft.yml)

- Starts only manually
- Can be used if you do not enforce Pull Request-based updates and commit directly to `target` branch
- Creates or updates a release draft for `target` branch
- If Release draft does not exist or has empty notes - notes are populated from `Unreleased` section of `CHANGELOG.md`
- Sets suggested version as `name` and `tag` of the Release

```bash
# download workflows to GitHub Action directory
# run this command from a GitHub repository root
curl https://github.com/vemel/nextversion/blob/main/nodejs_workflows/on_demand_create_release_draft.yml -o nodejs_workflows/on_demand_create_release_draft.yml
```

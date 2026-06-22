# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repository is

This is **training material**, not an application. It is a hands-on Kubernetes Helm course delivered through GitHub Codespaces. Each top-level numbered directory (`01_…` through `12_…`) is one self-contained lab that a trainee works through in order. There is nothing to build or deploy as a product — the "code" is the lab content, and the deliverable is a correct, clear, working lab.

The labs run inside a prebuilt devcontainer image (`quay.io/kubermatic-labs/training-ghcs-kubernetes-helm-trainee-environment`) that ships docker, kind, kubectl, kubectx/kubens, helm, and kustomize. A kind cluster (`my-cluster`) plus `cloud-provider-kind` and ingress-nginx are created by `postCreateCommand: /setup_kind_cluster.sh`. The host paths used by trainees live under `/workspaces/helm/<lab>` — lab READMEs `cd` there, so any commands you suggest should match that path.

## Lab anatomy

Every lab follows the same convention:

- `README.md` — the trainee-facing instructions, written as a sequence of fenced `bash`/`yaml` blocks the trainee copies and runs. Most labs ask the trainee to **edit a starter chart**, then install/verify, then clean up. This README is the primary artifact; treat its prose and commands as the source of truth.
- A starter Helm chart (e.g. `color-viewer/`, `my-chart/`, `my-app/`) that is intentionally incomplete — the lab walks the trainee through completing it.
- `.solution/` — the finished version of the chart. **Starter and solution must stay in sync**: when you change a chart's structure, values, or templates, apply the corresponding change to both the starter and `.solution/`, and make sure the README's edit steps still transform the starter into the solution.

The course arc: manifests-only (`01`) → kustomize (`02`) → first Helm chart (`03`) → rollback (`04`) → values/variables (`05`) → functions (`06`) → includes (`07`) → conditionals (`08`) → `required` (`09`) → tests (`10`) → hooks (`11`) → dependencies (`12`).

## Verifying the environment

```bash
make verify   # checks .trainingrc, tooling versions, and runs pre-checks.sh
```

`pre-checks.sh` confirms the kind containers are up, prints cluster-info, and checks that `INGRESS_IP` is exported. Trainees reach apps via `curl http://${INGRESS_IP}/…` or a port-forward to `ingress-nginx-controller`.

## Working on labs

There is no test runner or linter in the usual sense. Validate Helm changes the way the labs do:

```bash
helm install <name> ./<chart>            # or: helm install <name> --set key=val ./<chart>
helm template ./<chart>                  # render without installing — useful to check templating
helm uninstall <name>                    # every lab ends with a cleanup step
helm dependency update ./<chart>         # lab 12 only
```

When editing a lab, keep the README's copy-paste blocks runnable end to end inside the devcontainer, and preserve the cleanup section so trainees don't leave dangling releases.

## Skills (invoke via `/`)

Three repo-local skills assist with maintaining lab content:

- `code-linter` ("lint code") — checks code blocks and YAML inside labs.
- `md-linter` ("lint md") — checks README prose for typos/grammar, ignoring code.
- `secrets-remover` ("remove secrets") — scans for credentials before pushing.

Both linters scope themselves: a numeric argument (e.g. `05`) targets that one lab; otherwise they restrict to `git diff` changes if any exist, else scan all `*/README.md`. They skip `.99_todos/`. Note: the linter skill text references a `/training` path prefix, but the actual labs use `/workspaces/helm/` — follow the labs.

## Conventions and excluded paths

- `.99_todos/` holds the maintainer's backlog of slide/lab improvements — not trainee-facing. The devcontainer hides it (along with `.git`, `.devcontainer`, `pre-checks.sh`, `makefile`, `.claude/`, `CLAUDE.md`) from the trainee's VS Code via `files.exclude`. When adding maintainer-only tooling, add it to that exclude list too.
- Lab directories are numbered to enforce order; preserve the `NN_name` prefix so the linters' numeric resolution and the sequence keep working.

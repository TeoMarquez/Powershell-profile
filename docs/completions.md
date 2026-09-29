
# Completions

Autocompletado personalizado para módulos de Python.

## `python.ps1`

Completa módulos al usar `-m` con:

* `python`
* `python.exe`
* `python3`
* `py`
* `poetry`
* `uv`

Ejemplos:

```text
python -m <TAB>
python -m extractor.<TAB>
poetry run python -m <TAB>
poetry run python -m extractor.<TAB>
```

Ignora directorios como:

* `node_modules`
* `venv`
* `env`
* `dist`
* `build`
* `site-packages`

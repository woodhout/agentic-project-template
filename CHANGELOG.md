# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Fixed

- Fixed 34 markdown linting issues (MD040, MD031, MD029, MD025, MD041) across documentation, skills, and workflows.
- Added language specifiers (`text`, `bash`, `python`) to all fenced code blocks.
- Fixed blank lines around fences, ordered list numbering, and duplicate headings.

### Added

- Added `/bootstrap` workflow to automate project creation from Gem seed files.
- Added comprehensive agentic development infrastructure in `template/`.
- Added technical and non-technical Gemini Gem prompts in `gem-prompts/`.
- Initialized project scaffolding with support for Jules automation.

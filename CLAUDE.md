# CLAUDE.md - AI Assistant Guide for bug_detection Repository

## Project Overview

This repository is a **free collection of AI prompts and testing tools for quality assurance and software testing**. It's designed to help QA engineers and software testers with various testing activities throughout the software development lifecycle.

**Repository**: `NewFeatureBranchTester/bug_detection`
**Primary Language**: Mixed (TypeScript, Python, German documentation)
**Status**: Work in progress (2025)

## Tech Stack

### Core Technologies
- **Node.js** (CommonJS module system)
- **TypeScript** - For test automation
- **Playwright** v1.56.1 - Browser automation and E2E testing
- **Python 3** - Utility scripts (web scraping, data processing)
- **VBA/Excel** - Office automation with xlwings

### Development Dependencies
- `@playwright/test` v1.56.1
- `@types/node` v24.10.1
- Python packages: `requests`, `beautifulsoup4`, `xlwings`

## Directory Structure

```
bug_detection/
├── tests/                    # Playwright test specifications
│   ├── example.spec.ts      # Basic Playwright examples
│   ├── cart_AddAllProducts.spec.ts
│   ├── mindmap.md           # Test planning mindmap
│   └── image/               # Test assets and screenshots
├── testprompts/             # AI prompts for testing activities
│   ├── Testaktivitaeten.xlsx
│   ├── Testaktivitaeten_backup.csv
│   └── TP3_TDF/             # Test phase 3 (Testdurchführung)
│       ├── TP3_TA31_SOLL-IST-Vergleich/
│       └── TP3_TA32_Optimierung von Bug-Reports/
├── python/                  # Python utility scripts
│   └── syllabus.py         # Downloads ISTQB syllabi PDFs
├── myproject/              # Excel/xlwings integration project
│   ├── myproject.py        # Python-Excel automation
│   └── myproject.xlsm      # Excel macro-enabled workbook
├── vba/                    # VBA scripts and test files
│   ├── test-xlwings.vbs
│   ├── test-xlwings_history.txt
│   └── Mappe1.xlsx
├── pw/                     # Playwright documentation
│   └── docu_playwright.md
├── .github/                # GitHub Actions workflows
│   ├── workflows/
│   │   ├── playwright.yml  # Automated test execution
│   │   └── codeql.yml     # Security scanning
│   └── dependabot.yml     # Dependency updates
├── playwright.config.ts    # Playwright configuration
├── package.json           # Node.js dependencies
└── README.md             # Project documentation
```

## Codebase Conventions

### Language & Documentation
- **Primary documentation language**: German (Deutsch)
- **Code comments**: Minimal, rely on self-documenting code
- **Test descriptions**: English in spec files, German in planning docs
- **Naming conventions**:
  - Test files: `descriptive_name.spec.ts`
  - Python files: `snake_case.py`
  - Directories: lowercase, sometimes with spaces (German naming)

### Testing Conventions

#### Test Organization
Tests are organized by **testing phases** following ISTQB methodology:

1. **Anforderungsanalyse & Testplanung** (Requirements Analysis & Test Planning)
2. **Testentwurf & Testvorbereitung** (Test Design & Preparation)
3. **Testdurchführung** (Test Execution) - TP3_TDF
4. **Testabschluss & Berichterstattung** (Test Completion & Reporting)
5. **KI-spezifische Testaktivitäten** (AI-specific Test Activities)

#### Test Status Markers
In `tests/mindmap.md`, tests use these status markers:
- `[passed]` - Test passed successfully
- `[failed: reason]` - Test failed with reason
- `[open]` - Test not yet executed
- `[finished with bugs]` - Test completed but found issues
- `[n/a]` - Not applicable
- `[blocked]` - Test execution blocked

#### Playwright Configuration
- **Test directory**: `./tests`
- **Parallel execution**: Enabled (`fullyParallel: true`)
- **Retry logic**: 2 retries on CI, 0 locally
- **Browser**: Chromium (Desktop Chrome)
- **Reporter**: HTML
- **Trace**: Collected on first retry only
- **CI mode**: Single worker, no parallel tests

### Python Conventions
- Use `requests` and `BeautifulSoup` for web scraping
- Create output directories with `os.makedirs(exist_ok=True)`
- Download files to `pdf_downloads/` directory
- Clear progress messages with `print()` statements

### Git Workflow

#### Branching Strategy
- **Main branch**: `main`
- **Development branches**: Use `claude/` prefix for AI-assisted development
  - Format: `claude/claude-md-mids1tu7gj31rs3p-{session-id}`
- **Always develop on feature branches**, never directly on main

#### Commit Guidelines
- Clear, descriptive commit messages
- Use conventional commits where applicable
- Commits may be in German or English
- Recent example: "Add initial mindmap for testing paths and results"

#### CI/CD Triggers
- **Playwright tests**: Run on push/PR to `main` or `master`
- **CodeQL scanning**:
  - On push to `main`
  - On PR to `main`
  - Weekly schedule (Mondays at 11:33)

## AI Prompts Library

### Structure
The `testprompts/` directory contains AI prompts organized by:
- **Test Phase** (e.g., TP3_TDF = Test Phase 3: Testdurchführung)
- **Test Activity** (e.g., TA32 = Test Activity 32)
- **Activity Name** (e.g., "Optimierung von Bug-Reports")

### Prompt Format
Prompts follow a structured interview-based approach:
1. Set AI role and expertise
2. Define clear objectives
3. Use step-by-step instructions
4. Include output schemas/templates
5. Specify tone (e.g., "Duze mich" = use informal "you")

### Example Activities
- **TA31**: SOLL-IST-Vergleich (Expected vs. Actual comparison)
- **TA32**: Optimierung von Bug-Reports (Bug report optimization)
  - Multi-step process with prompt files
  - Interview mode to gather details
  - Structured output with severity/priority

## Development Workflows

### Setting Up the Project

```bash
# Install Node.js dependencies
npm ci

# Install Playwright browsers
npx playwright install --with-deps

# Run tests
npx playwright test

# Run tests in UI mode (interactive)
npx playwright test --ui

# View test report
npx playwright show-report
```

### Python Setup

```bash
# Install Python dependencies
pip install requests beautifulsoup4 xlwings

# Run syllabus downloader
cd python
python syllabus.py
```

### Running Tests Locally

```bash
# Run all tests
npx playwright test

# Run specific test file
npx playwright test tests/example.spec.ts

# Run in headed mode (see browser)
npx playwright test --headed

# Debug mode
npx playwright test --debug
```

### Creating New Tests

When creating new Playwright tests:

1. **Use TypeScript** (`.spec.ts` extension)
2. **Import test framework**: `import { test, expect } from '@playwright/test';`
3. **Use descriptive test names**: `test('user can login with valid credentials', ...)`
4. **Follow Page Object Model** where appropriate
5. **Add to mindmap**: Update `tests/mindmap.md` with test status
6. **Use proper assertions**: Prefer `expect(page).toHaveTitle()` over manual checks

Example test structure:
```typescript
import { test, expect } from '@playwright/test';

test('descriptive test name', async ({ page }) => {
  // Arrange
  await page.goto('https://example.com');

  // Act
  await page.getByRole('button', { name: 'Submit' }).click();

  // Assert
  await expect(page.getByText('Success')).toBeVisible();
});
```

## Working with AI Prompts

### Creating New Prompts

1. **Identify test phase and activity** from the ISTQB structure
2. **Create directory**: `testprompts/TP{X}_{CODE}/TP{X}_TA{XX}_{Activity-Name}/`
3. **Name files descriptively**:
   - Use `.prompt` extension for AI prompts
   - Use step numbers for multi-step processes
   - Include `.md` files for supplementary documentation
4. **Follow the interview pattern** used in existing prompts
5. **Include output templates** to ensure consistent results

### Prompt Best Practices

- **Set clear context**: Define AI's role and expertise
- **Use German** for prompts targeting German-speaking QA teams
- **Provide schemas**: Include expected output format
- **Multi-step processes**: Break complex tasks into numbered steps
- **Request one question at a time**: For interview-style prompts

## Testing Strategy

### Test Types Covered

Based on `README.md` structure, the repository supports:

1. **Functional Testing**
   - Test case design and creation
   - Test scenario development
   - Acceptance criteria definition

2. **Regression Testing**
   - Risk-based regression test selection
   - Re-testing of fixed bugs

3. **Exploratory Testing**
   - Edge case discovery
   - Unstructured test exploration

4. **Performance Testing**
   - Load and stress test preparation

5. **Security Testing**
   - Security test preparation and execution

6. **AI-Specific Testing**
   - Training data validation
   - Bias and fairness testing
   - Robustness and adversarial testing
   - Model interpretability tests
   - Continuous monitoring

### Test Planning Approach

Reference the comprehensive test activities table in `README.md`:
- 60+ distinct test activities
- Covers complete SDLC testing lifecycle
- Includes specialized AI/ML testing activities

## Security & Quality

### Security Scanning
- **CodeQL Advanced**: Automated security scanning via GitHub Actions
- Runs weekly and on every PR to main
- Multi-language support configured

### Dependency Management
- **Dependabot**: Weekly automated dependency updates
- Configured for npm packages
- Updates proposed via automated PRs

### Code Quality
- TypeScript strict checking (via `@types/node`)
- Playwright best practices enforced
- CI runs all tests before merge

## Common Tasks for AI Assistants

### 1. Adding a New Test
```typescript
// 1. Create file in tests/ directory
// 2. Import Playwright test framework
import { test, expect } from '@playwright/test';

// 3. Write test with clear description
test('user can add product to cart', async ({ page }) => {
  // Implementation
});

// 4. Update tests/mindmap.md with test status
```

### 2. Creating a New AI Prompt
```
1. Identify test phase (TP1-TP5)
2. Assign test activity number (TA01-TA67)
3. Create directory: testprompts/TP{X}_{Phase}/TP{X}_TA{XX}_{Name}/
4. Create .prompt file with structured content
5. Update README.md if needed
```

### 3. Running and Debugging Tests
```bash
# Specific test file
npx playwright test tests/example.spec.ts

# With browser visible
npx playwright test --headed

# Debug mode with Playwright Inspector
npx playwright test --debug

# Generate trace
npx playwright test --trace on
```

### 4. Updating Documentation
- **README.md**: Main project overview and test activities table
- **tests/mindmap.md**: Test execution status and planning
- **pw/docu_playwright.md**: Playwright-specific documentation
- **SECURITY.md**: Security policy and vulnerability reporting

### 5. Working with Python Utilities
```bash
# Download ISTQB syllabi
cd python
python syllabus.py
# PDFs saved to pdf_downloads/ directory
```

## Important Notes for AI Assistants

### Do's ✅
- **Read existing files** before making changes
- **Follow the established directory structure**
- **Use German** for test planning documents and prompts when appropriate
- **Update mindmap.md** when adding/modifying tests
- **Run tests** before committing changes
- **Use TypeScript** for all Playwright tests
- **Follow ISTQB methodology** for test organization
- **Create descriptive commit messages**
- **Respect the multi-language nature** (German docs, English code)

### Don'ts ❌
- **Don't create tests without reading existing patterns**
- **Don't skip the mindmap.md** test tracking system
- **Don't add dependencies** without updating package.json
- **Don't commit to main** - use feature branches
- **Don't ignore CI failures** - fix tests before pushing
- **Don't create JavaScript files** - this is a TypeScript project for tests
- **Don't mix languages** inappropriately (e.g., German in code comments)
- **Don't skip PDF downloads** directory in gitignore (already configured)

## File Patterns to Ignore

Per `.gitignore`:
- `node_modules/`
- `test-results/`
- `playwright-report/`
- `blob-report/`
- `playwright/.cache/`
- `playwright/.auth/`
- `pdf_downloads/` (generated by Python scripts)
- `.qodo/`
- Various VS Code configurations

## Quick Reference

### Key Files
- `package.json` - Dependencies and project metadata
- `playwright.config.ts` - Test runner configuration
- `README.md` - Comprehensive test activities reference
- `tests/mindmap.md` - Current test execution status
- `.github/workflows/playwright.yml` - CI/CD pipeline

### Key Commands
```bash
npm ci                          # Install dependencies
npx playwright install         # Install browsers
npx playwright test            # Run all tests
npx playwright test --ui       # Interactive mode
npx playwright show-report     # View results
npx playwright codegen         # Generate test code
```

### Repository URLs
- **Issues**: https://github.com/NewFeatureBranchTester/bug_detection/issues
- **Main branch**: https://github.com/NewFeatureBranchTester/bug_detection

## Testing Phases Reference

Quick lookup for test phase codes:

- **TP1**: Anforderungsanalyse & Testplanung
- **TP2**: Testentwurf & Testvorbereitung
- **TP3**: Testdurchführung (TDF)
- **TP4**: Testabschluss & Berichterstattung
- **TP5**: KI-spezifische Testaktivitäten

## Future Considerations

Based on work-in-progress status:
- Expand AI prompt library with more test activities
- Add more Playwright test examples
- Enhance Python utilities for test data generation
- Implement more comprehensive CI/CD pipelines
- Add visual regression testing capabilities

---

**Last Updated**: 2025-11-24
**For Questions**: Refer to README.md or create an issue in the repository

# Development Best Practices

### General Coding guidelines

##### White Space
  * Each tab should be represented by spaces and should take up 2 spaces.
  * One white space between every method
  * Add a new line at the end of every file (to prevent git related issues)

##### Comments
  * Write comments above the relevant line (not inline or after)
  * Write one line comment above each section of code (ex. `# Validations`)
  * Use `TODO` to note missing features or functionality that should be added at a later date.
  * Use `FIXME` to note broken code that needs to be fixed.
  * Use `HACK` to note code smells where questionable coding practices were used and should be refactored away.

##### Naming
  * Class Names
    * Camel Case (ex. `SomeTestClass`)
  * Variables, Symbols, and Methods
    * Snake Case (ex. `some_variable`, `some_test_method`)
  * Constants
    * Screaming Snake Case (ex. `SOME_CONSTANT`)

##### Methods to Use
  * Because certain blank fields can be either nil or an empty string, we should use `present?` instead of `nil?` or `empty?`, etc.

### Before you put up a PR:
  * Run all tests and they all pass
    * Make sure there is 100% (or close to 100%) coverage as well
  * Make sure white space follows convention
  * Make sure variable and method naming follows convention
  * Write brief summary of what you did in PR description

### Models
Structure your model code as follows: 
 
  1. Relationships
  2. Validations
  3. Scopes
  4. Public methods
  5. Private methods

###### Validation Standards 
  * validate presence of description for all models
  * for ranking models, validate numericality of ranking, only integer true
  * validate numericaly of foreign keys, only integer true 
  
###### Scope Standards
  * always include alphabetical scope
  * all ordering scopes should be named with by underscore attribute i.e `by_level` or `by_competency`
  * all filter scopes should be named with for underscore attribute i.e `for_level` or `for_competency`

### Controllers
Your controllers should include:
  * Actions
    * Index
    * Show
    * New
    * Create
    * Edit
    * Update
    * Destroy
  * Follow general 272 structure
    * use the private methods for set_{model_name} and {model_name}_params
  * Notices
    * flash[:notice] for all successes
    * show all errors
  * Notes
    * Don't use ! (bang methods) for example do "save" instead of "save!" and handle any errors that occur

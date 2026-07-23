# FN_RecipeValidator

---

# Purpose

Validates a feeding recipe before it is accepted by the PLC.

This function ensures that all recipe parameters are within the permitted operating limits.

If validation fails, the recipe shall not be executed.

---

# Function

```iecst
FUNCTION FN_RecipeValidator : BOOL

VAR_INPUT

    Recipe : ST_Recipe;

END_VAR

FN_RecipeValidator := TRUE;

IF Recipe.Enabled = FALSE THEN
    FN_RecipeValidator := FALSE;
END_IF;

IF Recipe.FeedAmountKg <= 0.0 THEN
    FN_RecipeValidator := FALSE;
END_IF;

IF Recipe.FeedingTimeSec = 0 THEN
    FN_RecipeValidator := FALSE;
END_IF;

IF (Recipe.DosingSpeedPercent < 0.0) OR
   (Recipe.DosingSpeedPercent > 100.0) THEN

    FN_RecipeValidator := FALSE;

END_IF;

IF (Recipe.BlowerSpeedPercent < 0.0) OR
   (Recipe.BlowerSpeedPercent > 100.0) THEN

    FN_RecipeValidator := FALSE;

END_IF;

IF Recipe.RepeatCount > 100 THEN
    FN_RecipeValidator := FALSE;
END_IF;
```

---

# Inputs

Recipe

Recipe structure to validate.

---

# Output

TRUE

Recipe is valid.

FALSE

Recipe contains invalid parameters.

---

# Validation Rules

The function checks

- Recipe Enabled
- Feed Amount
- Feeding Time
- Dosing Speed
- Blower Speed
- Repeat Count

---

# Example

```iecst
IF FN_RecipeValidator(Recipe := CurrentRecipe) THEN

    RecipeReady := TRUE;

ELSE

    AlarmCode := ALM_INVALID_RECIPE;

END_IF;
```

---

# Used By

- FB_RecipeManager
- FB_FeedingControlManager
- AquaFeed Manager
- Recipe Import

---

# Rules

The function shall never modify the recipe.

Validation must complete within one PLC scan.

No global variables shall be modified.

The function has no side effects.

---

# Future Validation

Additional validation rules may include

- Line compatibility
- Feed stock availability
- Scheduled execution conflicts
- Operator authorization
- Production limits

These checks shall be added without changing the function interface.
### 0.1.0.beta.2

*Radical changes to API*

- Method hook injected into controllers is now always 'tidy_strong_params' and no longer dynamically named based on the controller name.

- Naming improvements to methods in StrongParams. `attributes` -> `params` & Class method `build_list` -> 'restrict'
d45e3a01bea

*Additions*
- Ability to pass in required params (defaults to requiring nesting under resource name)
- New `params` method in StrongParams class allows conditional building params whitelist
- Option to pass scope to StrongParams class. Useful for things like current_user
- Tap method in StrongParams class for further modifications to whitelist before return 
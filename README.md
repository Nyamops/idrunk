To add a dictionary for your language, you need to create a translation file. For example, UI_EN.

You need these fields:
```
UI_DrunkSpeech_Dictionary_Filter
UI_DrunkSpeech_Dictionary_Case_Filter
```

### UI_DrunkSpeech_Dictionary_Filter
**Example:** _src/iDrunk/Contents/mods/iDrunk/media/lua/shared/Translate/EN/UI_EN.txt_
```json
[
  {
    "needle": [],
    "add": {
      "before": []
    }
  },
  {
    "needle": [],
    "replace": {
      "full": []
    }
  },
  {
    "needle": [],
    "add": {
      "after": []
    }
  }
]
```

### UI_DrunkSpeech_Dictionary_Case_Filter
Here you just need to specify the chars case. You can specify an empty json if you use hieroglyphs, etc.
```json
{}
```
# TemplatePreviewsService

Controllers for working with template objects for preview

## Getting all preview templates

```swift
let previews = try await TemplatePreviewsService.shared.templates
```
The ``OneEntryTemplatePreview`` array will be responsed

## Getting a preview template by its id

```swift
let preview = try await TemplatePreviewsService.shared.template(with: 1)
```

The ``OneEntryTemplatePreview`` model will be responsed

## Getting a preview template by its marker

```swift
let preview = try await TemplatePreviewsService.shared.template(with: "preview")
```

The ``OneEntryTemplatePreview`` model will be responsed

---
description: Python coding patterns and conventions
globs: ["**/*.py"]
alwaysApply: false
---

# Python Patterns

## Type Hints
- Required for all function signatures (params + return type)
- Use Pydantic models for data validation
- Use TypeVar and Generic for reusable types

## Async
- Use async/await for all I/O operations
- Use asyncio.gather() for concurrent operations
- Never mix sync and async code in hot paths

## Style
- Follow PEP 8 strictly
- Use structural pattern matching (Python 3.10+) over complex if/else
- Prefer dataclasses or Pydantic over plain dicts
- Use pathlib over os.path

## Error Handling
- Use specific exception types (never bare except)
- Create custom exceptions for domain errors
- Use contextlib for resource management

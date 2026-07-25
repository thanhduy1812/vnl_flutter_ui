Task: @task-uunxmw
Spec: @doc/specs/migrate-material-core/migrate-vnl-to-material-core
Status: deferred

# 07 — Scenarios (RUNTIME)

## Manual Runtime Checklist (for the USER to tick)

### vnl_ui_docs — All components

- [ ] Optimistic — correct right after the action
- [ ] Persisted — order/identity kept after reload
- [ ] Async refresh — position kept after update event
- [ ] Animation — refresh animates correctly, no visual glitch
- [ ] Re-entry — double-tap / repeated action doesn't duplicate or corrupt
- [ ] Business-correct — outcome matches the business rule after the action
- [ ] Negative — disallowed action rejected, no mutation

## Scenario Results

### Scenario 1 — Full visual regression
- Covers: AC — Zero visual regression trên vnl_ui_docs
- **Given:** Migrate hoàn tất, vnl_ui_docs chạy trên desktop + mobile, light + dark
- **When:** So sánh screenshot từng page với baseline trước migrate
- **Then:** Không có visual difference ngoài ripple effect của Material
- **Actual:**
- **Result:** Blocked
- **Evidence:**

## Coverage Summary

- Scenarios: (0 / 1)

## Misses → Fix


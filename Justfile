## Kaos Control development

.PHONY: build dev dev:backend dev:web run clean clean:web

# Build frontend and backend
build:
	cd web && pnpm run build
	go build -p 1 -ldflags "-X main.version=0.3.0 -X github.com/kaos-control/kaos-control/internal/http.Version=0.3.0" -o ./dist/kaos-control ./cmd/kaos-control

# Run everything in dev mode
dev:
	@echo "Starting both backend and frontend in dev mode..."
	@echo "Backend will run on http://localhost:4000"
	@echo "Frontend dev server will run on http://localhost:5173"
	@echo ""
	@echo "Run in separate terminals or use background jobs."
	@echo ""
	@echo "Backend:  just dev:backend"
	@echo "Frontend: just dev:web"

# Backend dev mode (go run with hot reload)
dev:backend:
	LOG_LEVEL=debug go run ./cmd/kaos-control -d

# Frontend dev mode (Vite dev server)
dev:web:
	cd web && pnpm run dev

# Run built binary
run:
	./dist/kaos-control -d

# Clean build artifacts
clean: clean:web
	rm -f ./dist/kaos-control

clean:web:
	rm -rf web/dist
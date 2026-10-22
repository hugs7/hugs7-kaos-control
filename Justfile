## Kaos Control development

# Build frontend and backend
build:
	cd web && pnpm run build
	go build -p 1 -ldflags "-X main.version=0.3.0 -X github.com/kaos-control/kaos-control/internal/http.Version=0.3.0" -o ./dist/kaos-control ./cmd/kaos-control

# Build frontend only
build-web:
	cd web && pnpm run build

# Run everything in dev mode (backend serves embedded frontend)
dev:
	@echo "Starting kaos-control on http://localhost:4000 (backend API + embedded Vue)..."
	@LOG_LEVEL=debug go run ./cmd/kaos-control -d

# Backend dev mode (go run with hot reload, serves embedded frontend)
dev-backend:
	LOG_LEVEL=debug go run ./cmd/kaos-control -d

# Frontend dev mode (Vite dev server on 5173, backend must run separately)
dev-web:
	cd web && pnpm run dev

# Run built binary
run:
	./dist/kaos-control -d

# Stop running server
stop:
	pkill -f "go run ./cmd/kaos-control" 2>/dev/null || true

# Clean build artifacts
clean:
	rm -f ./dist/kaos-control
	rm -rf web/dist

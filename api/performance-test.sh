#!/bin/bash

echo "=========================================="
echo "  Performance Tests - Harpoon API"
echo "=========================================="
echo ""

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

if [ -f .env ]; then
    export $(grep -v '^#' .env | grep APPLICATION_PORT | xargs)
fi

API_URL="http://localhost:${APPLICATION_PORT:-5000}"
CPU_CORES=$(nproc 2>/dev/null || sysctl -n hw.ncpu 2>/dev/null || echo 4)
THREADS=$CPU_CORES
CONNECTIONS=$((CPU_CORES * 10))
STRESS_CONNECTIONS=$((CPU_CORES * 20))

echo -e "${BLUE}💻 CPU detected: $CPU_CORES cores${NC}"
echo -e "${BLUE}⚙️  Configuration: $THREADS threads, $CONNECTIONS base connections${NC}"
echo ""

if ! command -v wrk &> /dev/null; then
    echo -e "${YELLOW}⚠️  wrk not found!${NC}"
    echo ""
    echo "To install:"
    echo "  Ubuntu/Debian: sudo apt-get install wrk"
    echo "  macOS: brew install wrk"
    echo "  Arch Linux: sudo pacman -S wrk"
    echo ""
    exit 1
fi

echo -e "${BLUE}🔍 Checking if API is online...${NC}"
if ! curl -s -f "$API_URL/company" > /dev/null 2>&1; then
    echo -e "${YELLOW}⚠️  API is not responding at $API_URL${NC}"
    echo ""
    echo "Make sure the application is running:"
    echo "  cd api && npm install && npm start"
    echo "  or"
    echo "  docker compose up"
    echo ""
    exit 1
fi

echo -e "${GREEN}✓ API is online!${NC}"
echo ""

run_test() {
    local test_name=$1
    local url=$2
    local threads=$3
    local connections=$4
    local duration=$5
    local description=$6

    echo "=========================================="
    echo -e "${GREEN}$test_name${NC}"
    echo "=========================================="
    echo "$description"
    echo ""
    echo "Threads: $threads"
    echo "Connections: $connections"
    echo "Duration: ${duration}s"
    echo "Endpoint: $url"
    echo ""

    wrk -t$threads -c$connections -d${duration}s "$url"
    echo ""
}

run_test \
    "Test 1: Company Listing (GET all)" \
    "$API_URL/company" \
    $THREADS \
    $CONNECTIONS \
    30 \
    "Listing all companies endpoint"

run_test \
    "Test 2: Get Company by ID" \
    "$API_URL/company/1" \
    $THREADS \
    $CONNECTIONS \
    30 \
    "Get single company by ID endpoint"

run_test \
    "Test 3: Rule Listing (GET all)" \
    "$API_URL/rule" \
    $THREADS \
    $CONNECTIONS \
    30 \
    "Listing all rules endpoint"

run_test \
    "Test 4: Alert Listing (GET all)" \
    "$API_URL/alerts" \
    $THREADS \
    $CONNECTIONS \
    30 \
    "Listing all alerts endpoint"

run_test \
    "Test 5: History Listing (GET all)" \
    "$API_URL/history" \
    $THREADS \
    $CONNECTIONS \
    30 \
    "Listing all history records endpoint"

run_test \
    "Test 6: Stress Test - Company Listing" \
    "$API_URL/company" \
    $THREADS \
    $STRESS_CONNECTIONS \
    60 \
    "Stress test with higher connections for company listing"

echo "=========================================="
echo -e "${GREEN}✓ All tests completed!${NC}"
echo "=========================================="

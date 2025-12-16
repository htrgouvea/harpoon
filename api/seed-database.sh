#!/bin/bash

echo "=========================================="
echo "  Seed Database - Harpoon API"
echo "=========================================="
echo ""

# Load environment variables
if [ -f .env ]; then
    export $(grep -v '^#' .env | xargs)
fi

API_URL="http://localhost:${APPLICATION_PORT:-5000}"

echo "Creating test companies..."
for i in {1..10}; do
    curl -s -X POST "$API_URL/company" \
        -H "Content-Type: application/json" \
        -d "{\"name\":\"Company $i\",\"email\":\"company$i@example.com\",\"status\":1}" > /dev/null
    echo "  ✓ Company $i created"
done

echo ""
echo "Creating test rules..."
for i in {1..20}; do
    company_id=$((($i % 10) + 1))
    curl -s -X POST "$API_URL/rule" \
        -H "Content-Type: application/json" \
        -d "{\"id_company\":$company_id,\"string\":\"rule-$i\",\"filter\":\"filter-$i\",\"score\":\"high\",\"description\":\"Test rule $i\",\"status\":1}" > /dev/null
    echo "  ✓ Rule $i created for company $company_id"
done

echo ""
echo "Creating test alerts..."
for i in {1..15}; do
    company_id=$((($i % 10) + 1))
    hash=$(echo -n "alert-$i-$(date +%s)" | md5sum | cut -d' ' -f1)
    curl -s -X POST "$API_URL/alerts" \
        -H "Content-Type: application/json" \
        -d "{\"id_company\":$company_id,\"status\":1,\"notification\":1,\"content\":\"Alert content $i\",\"hash\":\"$hash\"}" > /dev/null
    echo "  ✓ Alert $i created for company $company_id"
done

echo ""
echo "Creating test history records..."
for i in {1..15}; do
    company_id=$((($i % 10) + 1))
    curl -s -X POST "$API_URL/history" \
        -H "Content-Type: application/json" \
        -d "{\"id_company\":$company_id,\"source\":\"test-source-$i\",\"status\":1}" > /dev/null
    echo "  ✓ History record $i created for company $company_id"
done

echo ""
echo "=========================================="
echo "✓ Database seeded successfully!"
echo "=========================================="
echo ""
echo "Summary:"
echo "  - 10 companies"
echo "  - 20 rules"
echo "  - 15 alerts"
echo "  - 15 history records"
echo ""

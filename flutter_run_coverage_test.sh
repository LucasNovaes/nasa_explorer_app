echo "${LIGHTPURPLE}🤖 Run Test Coverage${dir:22}${NC}"
flutter test --coverage
echo "\n${PURPLE}📦 Generate HTML Coverage${NC}\n"
genhtml coverage/lcov.info --output=coverage
open coverage/index.html
echo ""

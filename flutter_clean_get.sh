echo "${LIGHTPURPLE}📂 ${dir:22}${NC}"
echo "\n${PURPLE}🧹 Cleaning${NC}\n"
flutter clean
rm pubspec.lock
echo "\n${PURPLE}🔻 Getting Packages${NC}\n"
flutter packages get
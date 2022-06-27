{ jdk }:
{
  packageOverrides = p: {
    gradle = (p.gradleGen.override {
      java = p.${jdk};
    }).gradle_latest;
  };
}


# typed: false
# frozen_string_literal: true

cask "nexuswork" do
  arch arm: "aarch64", intel: "x64"

  version "0.1.16"
  sha256 arm:   "4a8c221350a9120202d42bda2d44eaea30aa8859081adfc62743a17626bad4d0",
         intel: "fc60acb3fbd1b2883a90165ff2bfc6955bed6db830c797a0ca040f71380ae779"

  url "https://github.com/nexuswork-ai/nexuswork/releases/download/v#{version}/NexusWork_#{version}_#{arch}.dmg",
      verified: "github.com/nexuswork-ai/nexuswork/"
  name "NexusWork"
  desc "AI-powered work assistant with Claude Code and Codex integration"
  homepage "https://github.com/nexuswork-ai/nexuswork"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on macos: ">= :monterey"

  app "NexusWork.app"

  postflight do
    # Remove quarantine attribute to prevent Gatekeeper issues
    system_command "/usr/bin/xattr",
                   args: ["-r", "-d", "com.apple.quarantine", "#{appdir}/NexusWork.app"],
                   sudo: false
  end

  zap trash: [
    "~/Library/Application Support/ai.nexuswork.nexuswork",
    "~/Library/Caches/ai.nexuswork.nexuswork",
    "~/Library/Logs/ai.nexuswork.nexuswork",
    "~/Library/Preferences/ai.nexuswork.nexuswork.plist",
    "~/Library/Saved Application State/ai.nexuswork.nexuswork.savedState",
  ]
end

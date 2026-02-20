# typed: false
# frozen_string_literal: true

cask "nexuswork" do
  arch arm: "aarch64", intel: "40bb947e8a718f6adb3e298c9898ef89f3ff14a2baa575053cf4b0e45439d2bf"

  version "0.1.18"
  sha256 arm:   "def20d1092f1e436939259db4c79f72b175f7ef1f83b467440960b88b2cfcd94",
         intel: "40bb947e8a718f6adb3e298c9898ef89f3ff14a2baa575053cf4b0e45439d2bf"

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

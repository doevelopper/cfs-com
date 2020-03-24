#include <thread>

/// Types

struct Global {
  Global() {
    CHECK(folly::get_process_phase() == folly::ProcessPhase::Init);
  }

  ~Global() {
    CHECK(folly::get_process_phase() >= folly::ProcessPhase::Exit);
  }
};

/// Variables

static Global global;

/// Tests

TEST(InitTest, basic) {
  ASSERT_EQ(folly::get_process_phase(), folly::ProcessPhase::Regular);
}

TEST(InitTest, fork) {
  std::thread t1([] {
    ASSERT_EQ(folly::get_process_phase(), folly::ProcessPhase::Regular);
  });
  t1.join();
  folly::SingletonVault::singleton()->destroyInstances();
  auto pid = fork();
  folly::SingletonVault::singleton()->reenableInstances();
  if (pid > 0) {
    // parent
    int status = -1;
    auto pid2 = waitpid(pid, &status, 0);
    EXPECT_EQ(status, 0);
    EXPECT_EQ(pid, pid2);
    ASSERT_EQ(folly::get_process_phase(), folly::ProcessPhase::Regular);
  } else if (pid == 0) {
    // child
    std::thread t2([] {
      ASSERT_EQ(folly::get_process_phase(), folly::ProcessPhase::Regular);
    });
    t2.join();
    std::exit(0); // Do not print gtest results
  } else {
    PLOG(FATAL) << "Failed to fork()";
  }
}

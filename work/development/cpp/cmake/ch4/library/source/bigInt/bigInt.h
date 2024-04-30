#ifndef BIGINT_H
#define BIGINT_H
#include <cstdint>
#include <exception>
class UBigInt {

public:
  typedef enum {
    BIGINT_ERROR_NONE,
    BIGINT_ERROR_UNDERFLOW,
    BIGINT_ERROR_OVERFLOW,
    BIGINT_ERROR_UNDEFINED,
    BIGINT_ERROR_COUNT
  } BIGINT_E;

  UBigInt();
  UBigInt(uint64_t lhs, uint64_t rhs);
  UBigInt(const UBigInt &a);
  ~UBigInt();
  UBigInt operator+(const UBigInt &a) noexcept(false);
  void operator+=(const UBigInt &a) noexcept(false);
  UBigInt operator-(const UBigInt &a) noexcept(false);
  void operator-=(const UBigInt &a) noexcept(false);
  UBigInt operator*(const UBigInt &a) noexcept(false);
  void operator*=(const UBigInt &a) noexcept(false);
  UBigInt operator/(const UBigInt &a) noexcept(false);
  void operator/=(const UBigInt &a) noexcept(false);
  bool operator!=(const UBigInt &a);
  bool operator==(const UBigInt &a);
  bool operator<=(const UBigInt &a);
  bool operator>=(const UBigInt &a);
  bool operator<(const UBigInt &a);
  bool operator>(const UBigInt &a);
  BIGINT_E get_error() const noexcept;

private:
  uint64_t lhs;
  uint64_t rhs;
  BIGINT_E err;
};

#endif // !BIGINT_H

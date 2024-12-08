#include <windows.h>
#include <string>
#include <shlobj.h>
#include <filesystem>

int WINAPI WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR lpCmdLine, int nCmdShow)
{
    // Get executable path
    wchar_t exePath[MAX_PATH];
    GetModuleFileNameW(NULL, exePath, MAX_PATH);
    std::filesystem::path executablePath(exePath);
    std::filesystem::path directoryPath = executablePath.parent_path();

    // Set up process information
    STARTUPINFOW si;
    PROCESS_INFORMATION pi;
    ZeroMemory(&si, sizeof(si));
    si.cb = sizeof(si);
    ZeroMemory(&pi, sizeof(pi));

    // Create portable environment variables
    std::wstring env = L"SAUDICHAIN_PORTABLE=1\0SAUDICHAIN_DATA_DIR=.\\data\0";

    // Start wallet executable
    std::wstring cmdLine = directoryPath.wstring() + L"\\saudichain_wallet.exe";
    CreateProcessW(
        cmdLine.c_str(),
        NULL,
        NULL,
        NULL,
        FALSE,
        CREATE_UNICODE_ENVIRONMENT,
        (LPVOID)env.c_str(),
        directoryPath.c_str(),
        &si,
        &pi
    );

    // Wait for process to exit
    WaitForSingleObject(pi.hProcess, INFINITE);

    // Clean up
    CloseHandle(pi.hProcess);
    CloseHandle(pi.hThread);

    return 0;
}
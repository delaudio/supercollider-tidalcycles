(

// configure the sound server: here you could add hardware specific options
// see http://doc.sccode.org/Classes/ServerOptions.html

s.options.maxLogins = 2; // two logins

s.options.device = "Soundflower (64ch)"; // set audio interface

s.options.numBuffers = 1024 * 256; // increase this if you need to load more samples
s.options.memSize = 8192 * 16; // increase this if you get "alloc failed" messages
s.options.maxNodes = 1024 * 32; // increase this if you are getting drop outs and the message "too many nodes"

s.options.numOutputBusChannels = 24; // set output channel size
s.options.numInputBusChannels = 2; // set input channel size

s.reboot; // boot the server and start SuperDirt
s.waitForBoot {
	~dirt = SuperDirt(2, s); // two output channels, increase if you want to pan across more channels
	~dirt.loadSoundFiles;   // load samples (path containing a wildcard can be passed in)
	~dirt.loadSoundFiles("/Users/federico/samples/*");
	s.sync; // optionally: wait for samples to be read
	~dirt.start(57120, [0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46]);   // start listening on port 57120, create buses

};

s.latency = 0.3; // increase this if you get "late" messages
);


MIDIClient.init;

~midiOut = MIDIOut.newByName("Driver IAC", "Bus IAC 1");

~midiOut.latency = 0;

~dirt.soundLibrary.addMIDI(\midi, ~midiOut);



Server.killAll; //kill server
